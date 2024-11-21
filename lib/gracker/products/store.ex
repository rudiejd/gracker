defmodule Gracker.Product.Store do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(name address)a

  schema "stores" do
    field :name, :string
    field :address, :string

    has_many(:prices, ProductPrice)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
