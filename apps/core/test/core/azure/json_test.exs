defmodule Core.Azure.JSONTest do
  @moduledoc false

  use Core.DataCase, async: true

  alias Core.Azure.JSON

  describe "when receipt is from Silpo" do
    test "returns valid response" do
      response =
        "test/support/assets/output/silpo_result.json"
        |> File.read!()
        |> Jason.decode()

      assert %{"items" => [_ | _], "merchant_name" => _, "total" => _, "transaction_time" => _} = JSON.parse(response)
    end
  end

  describe "when status is running" do
    test "returns error" do
      response =
        "test/support/assets/output/running_result.json"
        |> File.read!()
        |> Jason.decode()

      assert {:error,
              %{
                "createdDateTime" => "2023-06-12T14:34:35Z",
                "lastUpdatedDateTime" => "2023-06-12T14:34:35Z",
                "status" => "running"
              }} = JSON.parse(response)
    end
  end
end
