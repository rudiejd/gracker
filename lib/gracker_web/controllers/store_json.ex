defmodule GrackerWeb.StoreJSON do
  alias Gracker.Products.Store

  @doc """
  Renders a list of stores.
  """
  def index(%{stores: stores}) do
    %{data: for(store <- stores, do: data(store))}
  end

  @doc """
  Renders a single store.
  """
  def show(%{store: store}) do
    %{data: data(store)}
  end

  defp data(%Store{} = store) do
    %{
      id: store.id,
      name: store.name,
      address: store.address
    }
  end
end
