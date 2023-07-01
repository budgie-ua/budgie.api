import Config

config :jobs,
  env: Mix.env()

config :jobs, Oban,
  queues: [default: 5],
  repo: Core.Repo

import_config "#{Mix.env()}.exs"
