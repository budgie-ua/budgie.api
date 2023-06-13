defmodule Core.Costs.Schemas.Item do
  @moduledoc false

  use Ecto.Schema

  embedded_schema do
    field(:name, :string)
    field(:price, :float)
    field(:quantity, :utc_datetime)
    field(:total_price, :utc_datetime)
  end
end
