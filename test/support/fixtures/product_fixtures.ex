defmodule Gracker.ProductFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gracker.Product` context.
  """

  @doc """
  Generate a store.
  """
  def store_fixture(attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name"
      })
      |> Gracker.Product.create_store()

    store
  end
end
