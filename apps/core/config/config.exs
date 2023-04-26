import Config

config :core,
  env: Mix.env(),
  http_client: Core.HTTP

config :core, :google_vision,
  access_token: System.get_env("GCLOUD_ACCESS_TOKEN", ""),
  api_key: System.get_env("GCLOUD_API_KEY", ""),
  project_id: System.get_env("GCLOUD_PROJECT_ID", "")

import_config "#{Mix.env()}.exs"
