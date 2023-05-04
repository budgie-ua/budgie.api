defmodule Core.Expectations.HTTP do
  @moduledoc false

  import Mox

  def expect_http_run(:ok, %{headers: headers, body: body}) do
    expect(HTTPMock, :run, fn _method, _url, _headers, _body ->
      {:ok, %Finch.Response{body: body, headers: headers, status: 200}}
    end)
  end

  def expect_http_run(:error, %{headers: headers, body: body}) do
    expect(HTTPMock, :run, fn _method, _url, _headers, _body ->
      {:ok, %Finch.Response{body: body, headers: headers, status: 400}}
    end)
  end

  def expect_http_run(:error, :timeout) do
    expect(HTTPMock, :run, fn _method, _url, _headers, _body ->
      {:error, %Mint.TransportError{reason: :timeout}}
    end)
  end
end
