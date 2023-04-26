defmodule Core.GoogleVision.Client do
  @moduledoc false

  alias Core.GoogleVision.Json

  @callback url() :: binary()
  @callback request() :: binary()

  @http_client Application.compile_env!(:core, :http_client)
  @success_http_statuses [200, 201, 204]

  defmacro __using__(_opts) do
    quote do
      @behaviour Core.GoogleVision.Client

      @spec call(image :: binary()) :: {:ok, map()} | {:error, binary()}
      def call(image) do
        Core.GoogleVision.Client.__call__(image, url(), request())
      end
    end
  end

  def __call__(image, url, request) do
    case @http_client.run(
           url,
           headers(),
           build_body(request, image)
         ) do
      {:ok, %{body: response, status: status}} when status in @success_http_statuses ->
        Json.parse(response)

      error ->
        error
    end
  end

  defp headers do
    [
      {"Authorization", "Bearer #{config()[:access_token]}"},
      {"x-goog-user-project", config()[:project_id]},
      {"Content-Type", "application/json; charset=utf-8"}
    ]
  end

  defp build_body(request, image),
    do: EEx.eval_string(request, image: Base.encode64(image))

  defp config, do: Application.get_env(:core, :google_vision)
end
