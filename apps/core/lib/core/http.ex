defmodule Core.HTTP do
  @moduledoc """
  The module implements HTTP behavior.
  """

  @behaviour Core.HTTP.Behaviour

  @doc """
  Makes post request to the SOAP service.

  ## Parameters

    * `url` - Request url
    * `headers` - Request headers
    * `body` - Request body (json)
    * `opts` - Additional opts (optional)

  ## Examples

    iex> HTTP.run(
      "https://vision.googleapis.com/v1/images:annotate",
      [{"Content-Type", "application/json; charset=utf-8"}],
      "<?xml version="1.0" encoding="UTF-8"?>.....",
      [receive_timeout: 15_000]
    )
    {:ok, %Finch.Response{status: 200, headers: [], body: "<?xml version="1.0" encoding..."}}
  """
  @spec run(url :: binary(), headers :: list(), body :: binary()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def run(url, headers, body) do
    :post
    |> Finch.build(url, headers, body)
    |> Finch.request(Core.Finch)
  end
end
