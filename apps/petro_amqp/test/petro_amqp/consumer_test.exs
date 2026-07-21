defmodule PetroAmqp.ConsumerTest do
  require Logger
  alias PetroDB.Schemas.Event
  use ExUnit.Case, async: false

  test "init consumer" do
    Logger.info("init consumer")

    {:ok, channel} = AMQP.Application.get_channel(:rabbitmq_channel)
    AMQP.Basic.publish(channel, "petel_exchange", "", "Hello, World!")
  end

  test "parse message" do
    Logger.info("init consumer")
    {:ok, channel} = AMQP.Application.get_channel(:rabbitmq_channel)
    event = %Event{
      name: "event test",
      body: "body messsage",
      priority: 1
    }

    Logger.info(event)
    json_string = JSON.encode!(event)
    AMQP.Basic.publish(channel, "petel_exchange", "", json_string)
  end
  
  test "poolboy consumers" do
    Logger.info("poolboy consumers")
    {:ok, channel} = AMQP.Application.get_channel(:rabbitmq_channel)

    1..20
    |> Enum.each(fn i ->
      event = %Event{
        name: "event #{i}",
        body: "body messsage #{i}",
        priority: i
      }

      # IO.inspect(event)
      json_string = JSON.encode!(event)
      AMQP.Basic.publish(channel, "petel_exchange", "", json_string)
    end)
  end
end
