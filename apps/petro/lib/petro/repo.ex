defmodule Petro.Repo do
  use Ecto.Repo,
    otp_app: :petro,
    adapter: Ecto.Adapters.Postgres
end
