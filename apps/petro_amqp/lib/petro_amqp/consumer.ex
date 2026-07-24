defmodule PetroAmqp.Consumer do
  use GenServer
  require Logger
  alias PetroDB.Schemas.Event
  use AMQP
  alias PetroAmqp.Repo

  @exchange "petel_exchange"
  @queue "petel_queue"
  @queue_error "#{@queue}_error"

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(_state) do
    send(self(), {:subscribe})
    {:ok, %{}}
  end

  def handle_info({:subscribe}, channel) do
    Logger.debug("Consumer #{inspect(self())} :subscribe channel: #{inspect(channel)}")
    case subscribe() do
      {:ok, chan} ->
        {:noreply, chan}
      _ ->
        {:noreply, channel}
    end
  end
  
  def handle_info({:DOWN, _, :process, pid, reason}, %{channel: %{pid: pid}} = channel) do
    Logger.error("Consumer #{inspect(self())} :DOWN reason: #{inspect(reason)}")
    send(self(), {:subscribe})
    {:noreply, Map.put(channel, :channel, nil)}
  end

  # Confirmation from broker after consume
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, channel) do
    {:noreply, channel}
  end

  # Send by broker if unexpected error, like queue deleted
  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, channel) do
    {:stop, :normal, channel}
  end

  # Send by broker normal cancel
  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, channel) do
    {:stop, :normal, channel}
  end

  # Normal delivering
  def handle_info(
        {:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}},
        channel
      ) do
    consume(channel, tag, redelivered, payload)
    {:noreply, channel}
  end

  defp subscribe() do
    case AMQP.Application.get_channel(:rabbitmq_channel) do
      {:ok, channel} ->
        Logger.debug("Consumer #{inspect(self())} channel is opened")
        Process.monitor(channel.pid)
        setup_queue(channel)
        :ok = Basic.qos(channel, prefetch_count: Application.get_env(:amqp, :prefetch_count, 10))
        {:ok, _consumer_tag} = AMQP.Basic.consume(channel, @queue)
        {:ok, channel}

      error ->
        Logger.error("Consumer #{inspect(self())} error: #{inspect(error)}")
        Process.send_after(self(), :subscribe, 1000)
        {:error, :retrying}
    end
  end

  defp setup_queue(channel) do
    {:ok, _} = Queue.declare(channel, @queue_error, durable: true)
    # Undelivered messages routed to error queue
    {:ok, _} =
      Queue.declare(
        channel,
        @queue,
        durable: true,
        arguments: [
          {"x-dead-letter-exchange", :longstr, ""},
          {"x-dead-letter-routing-key", :longstr, @queue_error}
        ]
      )

    :ok = Exchange.direct(channel, @exchange, durable: true)
    :ok = Queue.bind(channel, @queue, @exchange)
  end

  defp consume(channel, tag, _redelivered, payload) do
    Logger.debug("process: #{inspect(self())} message: #{inspect(payload)} channel: #{inspect(channel)} tag: #{inspect(tag)}")
    with {:ok, map} <- JSON.decode(payload),
      changeset <- Event.changeset(map),
      {:ok, event} <- Ecto.Changeset.apply_action(changeset, :parse) do
        Repo.insert!(event)
        Logger.debug("event with name #{event.name} was saved")
        :ok = AMQP.Basic.ack(channel, tag)
    end
  rescue
    exception ->
      Logger.error("exception: #{inspect(exception)}")
      :ok = AMQP.Basic.reject(channel, tag, requeue: false)
  end
end
