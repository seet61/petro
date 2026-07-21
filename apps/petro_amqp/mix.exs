defmodule PetroAmqp.MixProject do
  use Mix.Project

  def project do
    [
      app: :petro_amqp,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PetroAmqp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.14"},
      {:postgrex, "~> 0.22"},
      {:amqp, "~> 4.1"},
      {:poolboy, "~> 1.5"},
      {:petro_db, in_umbrella: true}
    ]
  end
end
