defmodule Gracker.Products.Product do
  alias Gracker.Products.ProductPrice
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :upc, :string

    has_many(:prices, ProductPrice)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :upc])
    |> validate_required([:name, :upc])
  end
end
