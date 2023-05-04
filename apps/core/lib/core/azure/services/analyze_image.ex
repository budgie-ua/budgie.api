defmodule Core.Azure.Services.AnalyzeImage do
  @moduledoc false

  @http_client Application.compile_env!(:core, :http_client)
  @success_http_statuses [200, 201, 202, 204]

  @spec call(binary()) :: {:ok, binary()} | {:error, any()}
  def call(image) do
    case @http_client.run(
           :post,
           url(),
           headers(),
           build_body(image)
         ) do
      {:ok, %{headers: headers, status: status}} when status in @success_http_statuses ->
        {:ok, headers |> Enum.into(%{}) |> Map.get("operation-location")}

      {:ok, %{body: body}} ->
        {:error, Jason.decode!(body)}

      error ->
        error
    end
  end

  defp url do
    "https://#{config()[:name]}.cognitiveservices.azure.com/formrecognizer/documentModels/#{config()[:model_id]}:analyze?api-version=2022-08-31"
  end

  defp headers do
    [
      {"Ocp-Apim-Subscription-Key", config()[:api_key]},
      {"Content-Type", "application/json"}
    ]
  end

  defp build_body(image) do
    "{'base64Source': '#{Base.encode64(image)}'}"
  end

  defp config, do: Application.get_env(:core, :azure)
end
