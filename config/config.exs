# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config
import_config "#{config_env()}.exs"

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
config :logger, :default_handler,
  formatter: {LoggerJSON.Formatters.Basic, metadata: [:request_id]}


config :petro_front, :logger, [
  {:handler, :file_log, :logger_std_h,
   %{
     config: %{
       file: ~c"logs/petro_front.log",
       filesync_repeat_interval: 5000,
       file_check: 5000,
       max_no_bytes: 10_000_000,
       max_no_files: 5,
       compress_on_rotate: true
     }
   }}
]
