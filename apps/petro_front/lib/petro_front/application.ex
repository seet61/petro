defmodule PetroFront.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children =
      [
        PetroFront.Api
      ]


    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetroFront.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
