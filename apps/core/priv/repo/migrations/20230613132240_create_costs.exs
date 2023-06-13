defmodule Core.Repo.Migrations.CreateCosts do
  use Ecto.Migration

  def change do
    create table(:costs, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:items, {:array, :map}, default: [])
      add(:merchant_name, :string)
      add(:total, :float)
      add(:transaction_time, :utc_datetime)

      timestamps(type: :utc_datetime)
    end
  end
end
