defmodule Gracker.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gracker.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        upc: "some upc"
      })
      |> Gracker.Products.create_product()

    product
  end
end
