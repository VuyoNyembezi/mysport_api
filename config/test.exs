import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :mysport_api, MysportApi.Repo,
  username: "postgres",
  password: "12345",
  database: "mysport_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mysport_api, MysportApiWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "WJDiEbaR/PZIYpZYRemz+3Ex0kpkeMN7k+THtYQeV+KOWaOsVhVIKeW6Db7GOW4d",
  server: false

# In test we don't send emails.
config :mysport_api, MysportApi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
