defmodule GrackerWeb.StoreController do
  use GrackerWeb, :controller

  alias Gracker.Products
  alias Gracker.Products.Store

  def index(conn, _params) do
    stores = Products.list_stores()
    render(conn, :index, stores: stores)
  end

  def new(conn, _params) do
    changeset = Products.change_store(%Store{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"store" => store_params}) do
    case Products.create_store(store_params) do
      {:ok, store} ->
        conn
        |> put_flash(:info, "Store created successfully.")
        |> redirect(to: ~p"/stores/#{store}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    store = Products.get_store!(id)
    render(conn, :show, store: store)
  end

  def edit(conn, %{"id" => id}) do
    store = Products.get_store!(id)
    changeset = Products.change_store(store)
    render(conn, :edit, store: store, changeset: changeset)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Products.get_store!(id)

    case Products.update_store(store, store_params) do
      {:ok, store} ->
        conn
        |> put_flash(:info, "Store updated successfully.")
        |> redirect(to: ~p"/stores/#{store}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, store: store, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    store = Products.get_store!(id)
    {:ok, _store} = Products.delete_store(store)

    conn
    |> put_flash(:info, "Store deleted successfully.")
    |> redirect(to: ~p"/stores")
  end
end
