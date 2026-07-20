defmodule PetroWeb.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PetroWeb.Telemetry,
      # Start a worker by calling: PetroWeb.Worker.start_link(arg)
      # {PetroWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      PetroWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetroWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PetroWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
