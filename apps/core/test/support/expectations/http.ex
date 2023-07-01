defmodule Core.Expectations.HTTP do
  @moduledoc false

  import Mox

  def expect_http_get(:ok, %{headers: headers, body: body}) do
    expect(HTTPMock, :run, fn _method, _url, _headers ->
      {:ok, %Finch.Response{body: body, headers: headers, status: 200}}
    end)
  end

  def expect_http_get(:error, %{headers: headers, body: body}) do
    expect(HTTPMock, :run, fn _method, _url, _headers ->
      {:ok, %Finch.Response{body: body, headers: headers, status: 400}}
    end)
  end

  def expect_http_get(:error, :timeout) do
    expect(HTTPMock, :run, fn _method, _url, _headers ->
      {:error, %Mint.TransportError{reason: :timeout}}
    end)
  end

  def expect_http_post(:ok, %{headers: headers, body: body}) do
    expect(HTTPMock, :run, fn _method, _url, _headers, _body ->
      {:ok, %Finch.Response{body: body, headers: headers, status: 200}}
    end)
  end

  def expect_http_post(:error, %{headers: headers, body: body}) do
    expect(HTTPMock, :run, fn _method, _url, _headers, _body ->
      {:ok, %Finch.Response{body: body, headers: headers, status: 400}}
    end)
  end

  def expect_http_post(:error, :timeout) do
    expect(HTTPMock, :run, fn _method, _url, _headers, _body ->
      {:error, %Mint.TransportError{reason: :timeout}}
    end)
  end
end
