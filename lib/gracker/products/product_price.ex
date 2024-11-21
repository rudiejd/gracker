defmodule Gracker.Products.ProductPrice do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gracker.Products.Product

  @required_fields ~w(price date store_id product_id)

  schema "product_prices" do
    field :price, :decimal
    field :date, :utc_datetime
    belongs_to :product, Product, foreign_key: :product_id
    belongs_to :store, Store, foreign_key: :store_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
