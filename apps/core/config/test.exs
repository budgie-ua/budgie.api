import Config

config :logger, level: :warn

config :core,
  env: Mix.env(),
  http_client: HTTPMock

config :core, Core.Repo,
  username: "postgres",
  password: "postgres",
  database: "budgie_test",
  hostname: System.get_env("DB_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 120_000_000
