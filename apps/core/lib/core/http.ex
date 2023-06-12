defmodule Core.HTTP do
  @moduledoc """
  The module implements HTTP behavior.
  """

  @behaviour Core.HTTP.Behaviour

  @doc """
  Makes HTTP request.

  ## Parameters

    * `method` - Request method
    * `url` - Request url
    * `headers` - Request headers
    * `body` - Request body (json)

  ## Examples

    iex> HTTP.run(
      :post,
      "https://vision.googleapis.com/v1/images:annotate",
      [{"Content-Type", "application/json; charset=utf-8"}],
      "<?xml version="1.0" encoding="UTF-8"?>....."
    )
    {:ok, %Finch.Response{status: 200, headers: [], body: "<?xml version="1.0" encoding..."}}
  """
  @spec run(method :: Finch.Request.method(), url :: binary(), headers :: list(), body :: binary()) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def run(method, url, headers \\ [], body \\ nil) do
    method
    |> Finch.build(url, headers, body)
    |> Finch.request(Core.Finch)
  end
end
