import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :petro, Petro.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "petro_test#{System.get_env("MIX_TEST_PARTITION")}",
  #pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 5,
  parameters: [
    application_name: "Petro Application"
  ]

config :petro_amqp, PetroAmqp.Repo,
  username: "petro",
  password: "petro",
  hostname: "192.168.1.50",
  database: "petro_test",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 5,
  parameters: [
    application_name: "PetroAmqp Application"
  ]
  
config :petro_db, PetroDB.Repo,
  username: "petro",
  password: "petro",
  hostname: "192.168.1.50",
  database: "petro_test",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 5,
  parameters: [
    application_name: "PetroDB Application"
  ],
  migration_default_prefix: "petro"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :petro_web, PetroWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "qIcl4ce6qTljXZR4w9wTKUT7BU0up8nQTEXVKGQfHEg8Xi38GotSTzmFyrkCfQoV",
  server: false

# Print only warnings and errors during test
#config :logger, level: :warning
config :logger, :default_formatter, format: "[$level] $message\n"

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Sort query params output of verified routes for robust url comparisons
config :phoenix,
  sort_verified_routes_query_params: true

config :amqp,
  connections: [
    rabbitmq: [url: "amqp://petro:petro@192.168.1.50:5672/petro_test"]
  ],
  size: 5,
  max_overflow: 5
