defmodule Core.Azure.JSON do
  @moduledoc false

  @spec parse(binary()) :: map() | {:error, any()}
  def parse({:ok, %{"status" => "succeeded"} = data}) do
    process_documents(data["analyzeResult"]["documents"])
  end

  def parse({:ok, data}),
    do: {:error, data}

  defp process_documents([%{"fields" => fields}]) do
    %{
      "items" => process_items(fields["Items"]),
      "merchant_name" => get_in(fields, ~w(MerchantName valueString)),
      "total" => get_in(fields, ~w(Total valueNumber)),
      "transaction_time" => transaction_time(fields)
    }
  end

  defp process_items(%{"type" => "array", "valueArray" => items}),
    do: do_process_items(items, [])

  defp do_process_items([], acc),
    do: acc

  defp do_process_items([%{"valueObject" => item} | tail], acc),
    do: do_process_items(tail, [build_item(item) | acc])

  defp build_item(item) do
    %{
      "name" => get_in(item, ~w(Description valueString)),
      "price" => get_in(item, ~w(Price valueNumber)),
      "quantity" => get_in(item, ~w(Quantity valueNumber)),
      "total_price" => get_in(item, ~w(TotalPrice valueNumber))
    }
  end

  defp transaction_time(fields) do
    fields
    |> get_in(~w(TransactionDate valueDate))
    |> Kernel.<>(" ")
    |> Kernel.<>(get_in(fields, ~w(TransactionTime valueTime)))
    |> Timex.parse!("%Y-%m-%d %H:%M:%S", :strftime)
    |> Timex.to_datetime()
  end
end
