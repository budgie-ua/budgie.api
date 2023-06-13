import Config

config :core,
  env: Mix.env(),
  http_client: Core.HTTP,
  ecto_repos: [Core.Repo]

config :core, :azure,
  name: System.get_env("AZURE_NAME", ""),
  model_id: System.get_env("AZURE_MODEL_NAME", ""),
  api_key: System.get_env("AZURE_API_KEY", "")

import_config "#{Mix.env()}.exs"
