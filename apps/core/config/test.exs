import Config

config :logger, level: :warn

config :core,
  google_vision_client: GoogleVisionMock
