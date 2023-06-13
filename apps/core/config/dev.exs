import Config

config :logger, level: :debug

config :core, Core.Repo,
  username: "postgres",
  password: "postgres",
  database: "budgie_dev",
  hostname: System.get_env("DB_HOST", "localhost"),
  pool_size: 10,
  start_apps_before_migration: [:core]
