defmodule Core.Costs.Schemas.Cost do
  @moduledoc false

  use Ecto.Schema

  alias Core.Costs.Schemas.Item

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "costs" do
    field(:merchant_name, :string)
    field(:total, :float)
    field(:transaction_time, :utc_datetime)

    embeds_many(:items, Item)

    timestamps(type: :utc_datetime)
  end
end
