import Config

config :core,
  env: Mix.env(),
  http_client: HTTPMock

config :logger, level: :warn
