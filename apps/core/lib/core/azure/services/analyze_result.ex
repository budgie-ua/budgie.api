defmodule Core.Azure.Services.AnalyzeResult do
  @moduledoc false

  alias Core.Azure.JSON

  @http_client Application.compile_env!(:core, :http_client)
  @success_http_statuses [200, 201, 202, 204]

  @spec call(binary()) :: {:ok, map()} | {:error, any()}
  def call(url) do
    case @http_client.run(
           :get,
           url,
           headers()
         ) do
      {:ok, %{body: body, status: status}} when status in @success_http_statuses ->
        body |> Jason.decode() |> JSON.parse()

      {:ok, %{body: body}} ->
        {:error, Jason.decode!(body)}

      error ->
        error
    end
  end

  defp headers do
    [
      {"Ocp-Apim-Subscription-Key", config()[:api_key]},
      {"Content-Type", "application/json"}
    ]
  end

  defp config, do: Application.get_env(:core, :azure)
end
