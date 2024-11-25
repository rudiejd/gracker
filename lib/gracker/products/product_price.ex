defmodule Gracker.Products.ProductPrice do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gracker.Products.Product


  schema "product_prices" do
    field :price, :decimal
    field :date, :utc_datetime
    belongs_to :product, Product, foreign_key: :product_id
    belongs_to :store, Store, foreign_key: :store_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(price, attrs \\ %{}) do
    price
    |> cast(attrs, [:price, :date, :store_id, :product_id])
    |> validate_required([:price, :date, :store_id, :product_id])
  end
end
