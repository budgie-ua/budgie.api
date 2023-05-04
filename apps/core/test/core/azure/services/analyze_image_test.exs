defmodule Core.Azure.Services.AnalyzeImageTest do
  @moduledoc false

  use Core.DataCase, async: true

  import Mox

  alias Core.Azure.Services.AnalyzeImage

  setup :verify_on_exit!

  describe "when file is an image" do
    test "returns result link" do
      image = File.read!("test/support/assets/receipt.jpg")
      expect_http_run(:ok, %{headers: [{"operation-location", "https://cognitiveservices.azure.com"}], body: ""})

      assert {:ok, "https://cognitiveservices.azure.com"} = AnalyzeImage.call(image)
    end
  end

  describe "when file is a doc" do
    test "returns error" do
      doc = File.read!("test/support/assets/doc.txt")
      expect_http_run(:error, %{headers: [], body: "{\"error\":{\"code\":\"InvalidRequest\",\"message\":\"Invalid request.\",\"innererror\":{\"code\":\"InvalidContent\",\"message\":\"The file is corrupted or format is unsupported. Refer to documentation for the list of supported formats.\"}}}"})

      assert {:error, %{"error" => %{"code" => "InvalidRequest"}}} = AnalyzeImage.call(doc)
    end
  end

  describe "with timeout error" do
    test "returns {:error, %Mint.TransportError{reason: :timeout}}" do
      expect_http_run(:error, :timeout)

      assert {:error, %Mint.TransportError{reason: :timeout}} = AnalyzeImage.call("")
    end
  end
end
