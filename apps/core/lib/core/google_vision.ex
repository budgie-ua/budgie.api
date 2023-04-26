defmodule Core.GoogleVision do
  @moduledoc """
  The Google Vision API.
  """

  alias Core.GoogleVision.Services.AnnotateImage

  @doc """
  Makes request to the Vision API and detect text from image.

  ## Parameters

    * `image` -

  ## Examples

    iex> GoogleVision.annotate_image(<<255, ....>>)
    {:ok, [%{}]}
  """
  @spec annotate_image(image :: map()) :: {:ok, list()} | {:error, any()}
  defdelegate annotate_image(image), to: AnnotateImage, as: :call
end
