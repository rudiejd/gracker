defmodule Gracker.Repo.Migrations.AddProductPricesTable do
  use Ecto.Migration

  def change do
    create table(:product_prices) do
      add :price, :decimal
      add :date, :utc_datetime
      add :store, :string
      add :product_id, :id
      timestamps(type: :utc_datetime)
    end
  end
end
