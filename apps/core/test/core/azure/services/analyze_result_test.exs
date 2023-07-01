defmodule Core.Azure.Services.AnalyzeResultTest do
  @moduledoc false

  use Core.DataCase, async: true

  import Mox

  alias Core.Azure.Services.AnalyzeResult

  @url "https://{name}.cognitiveservices.azure.com/formrecognizer/documentModels/{model_id}/analyzeResults/7f3849a3-3570-496d-a30e-9d649c283d44?api-version=2022-08-31"

  setup :verify_on_exit!

  describe "when job processed" do
    test "returns parsed receipt" do
      body = File.read!("test/support/assets/output/silpo_result.json")

      expect_http_get(:ok, %{headers: [], body: body})

      assert {
               :ok,
               %{
                 "items" => [
                   %{"name" => "Багет270ФранцЗКуркою", "price" => nil, "quantity" => nil, "total_price" => 39.99},
                   %{"name" => "МлинціКгЗШинкТаСиром", "price" => 179, "quantity" => 0.228, "total_price" => 40.81}
                 ],
                 "merchant_name" => "Cisiono",
                 "total" => 80.8,
                 "transaction_time" => ~U[2021-07-15 13:52:32Z]
               }
             } = AnalyzeResult.call(@url)
    end
  end

  describe "when job is in process" do
    test "returns error" do
      expect_http_get(:ok, %{
        headers: [],
        body:
          "{\"status\":\"running\",\"createdDateTime\":\"2023-06-30T13:00:51Z\",\"lastUpdatedDateTime\":\"2023-06-30T13:00:51Z\"}"
      })

      assert {:error,
              %{
                "createdDateTime" => "2023-06-30T13:00:51Z",
                "lastUpdatedDateTime" => "2023-06-30T13:00:51Z",
                "status" => "running"
              }} = AnalyzeResult.call(@url)
    end
  end

  describe "with timeout error" do
    test "returns {:error, %Mint.TransportError{reason: :timeout}}" do
      expect_http_get(:error, :timeout)

      assert {:error, %Mint.TransportError{reason: :timeout}} = AnalyzeResult.call(@url)
    end
  end
end
