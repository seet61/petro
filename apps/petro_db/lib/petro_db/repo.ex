defmodule PetroDB.Repo do
  use Ecto.Repo,
    otp_app: :petro_db,
    adapter: Ecto.Adapters.Postgres
end
