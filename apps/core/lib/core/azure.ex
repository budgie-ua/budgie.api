defmodule Core.Azure do
  @moduledoc """
  The Azure Cognitive API.
  """

  alias Core.Azure.Services.AnnotateImage

  @doc """
  Makes request to the Vision API and detect text from image.

  ## Parameters

    * `image` - binary representation of image

  ## Examples

    iex> Azure.annotate_image(<<255, ....>>)
    {:ok, "https://#{name}.cognitiveservices.azure.com/formrecognizer/documentModels/#{model_id}/analyzeResults/7f3849a3-3570-496d-a30e-9d649c283d44?api-version=2022-08-31"}
  """
  @spec annotate_image(image :: binary()) :: {:ok, binary()} | {:error, any()}
  defdelegate annotate_image(image), to: AnnotateImage, as: :call
end
