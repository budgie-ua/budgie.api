import Config

config :logger, level: :warn

config :jobs, Oban, queues: false, plugins: false
