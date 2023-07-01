defmodule Core.Azure do
  @moduledoc """
  The Azure Cognitive API.
  """

  alias Core.Azure.Services.{
    AnalyzeImage,
    AnalyzeResult
  }

  @doc """
  Makes request to the Vision API and detect text from image.

  ## Parameters

    * `image` - binary representation of image

  ## Examples

    iex> Azure.analyze_image(<<255, ....>>)
    {:ok, "https://{name}.cognitiveservices.azure.com/formrecognizer/documentModels/{model_id}/analyzeResults/7f3849a3-3570-496d-a30e-9d649c283d44?api-version=2022-08-31"}
  """
  @spec analyze_image(image :: binary()) :: {:ok, binary()} | {:error, any()}
  defdelegate analyze_image(image), to: AnalyzeImage, as: :call

  @doc """
  Makes request to the Vision API and gets detection job result.

  ## Parameters

      * `url` - job result url

  ## Examples

    iex> Azure.analyze_result("https://{name}.cognitiveservices.azure.com/formrecognizer/documentModels/{model_id}/analyzeResults/7f3849a3-3570-496d-a30e-9d649c283d44?api-version=2022-08-31")
    {:ok, %{"items" => [], "merchant_name" => nil, "total" => 264.4, "transaction_time" => ~U[2022-01-11 11:29:50Z]}
  """
  @spec analyze_result(url :: binary()) :: {:ok, map()} | {:error, map()}
  defdelegate analyze_result(url), to: AnalyzeResult, as: :call
end
