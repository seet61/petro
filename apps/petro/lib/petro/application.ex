defmodule Petro.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Petro.Repo,
      {DNSCluster, query: Application.get_env(:petro, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Petro.PubSub}
      # Start a worker by calling: Petro.Worker.start_link(arg)
      # {Petro.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Petro.Supervisor)
  end
end
