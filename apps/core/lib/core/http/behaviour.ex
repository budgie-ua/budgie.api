defmodule Core.HTTP.Behaviour do
  @moduledoc false

  @callback run(url :: binary(), headers :: list(), body :: binary()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
end
