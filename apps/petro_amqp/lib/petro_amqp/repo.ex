defmodule PetroAmqp.Repo do
  use Ecto.Repo,
    otp_app: :petro_amqp,
    adapter: Ecto.Adapters.Postgres
end
