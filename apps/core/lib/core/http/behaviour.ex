defmodule Core.HTTP.Behaviour do
  @moduledoc false

  @callback run(method :: Finch.Request.method(), url :: binary()) ::
              {:ok, Finch.Response.t()} | {:error, Exception.t()}
  @callback run(method :: Finch.Request.method(), url :: binary(), headers :: list()) ::
              {:ok, Finch.Response.t()} | {:error, Exception.t()}
  @callback run(method :: Finch.Request.method(), url :: binary(), headers :: list(), body :: binary()) ::
              {:ok, Finch.Response.t()} | {:error, Exception.t()}
end
