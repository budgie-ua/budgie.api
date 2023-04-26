defmodule Core.GoogleVision.Services.AnnotateImage do
  @moduledoc false

  use Core.GoogleVision.Client

  def url do
    "https://vision.googleapis.com/v1/images:annotate?key=#{config()[:api_key]}"
  end

  def request do
    :core
    |> Application.app_dir("priv/google_vision/images:annotate.json")
    |> File.read!()
  end

  defp config, do: Application.get_env(:core, :google_vision)
end
