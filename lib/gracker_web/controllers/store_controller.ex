defmodule GrackerWeb.StoreController do
  use GrackerWeb, :controller

  alias Gracker.Product
  alias Gracker.Product.Store

  action_fallback GrackerWeb.FallbackController

  def index(conn, _params) do
    stores = Product.list_stores()
    render(conn, :index, stores: stores)
  end

  def create(conn, %{"store" => store_params}) do
    with {:ok, %Store{} = store} <- Product.create_store(store_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/stores/#{store}")
      |> render(:show, store: store)
    end
  end

  def show(conn, %{"id" => id}) do
    store = Product.get_store!(id)
    render(conn, :show, store: store)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Product.get_store!(id)

    with {:ok, %Store{} = store} <- Product.update_store(store, store_params) do
      render(conn, :show, store: store)
    end
  end

  def delete(conn, %{"id" => id}) do
    store = Product.get_store!(id)

    with {:ok, %Store{}} <- Product.delete_store(store) do
      send_resp(conn, :no_content, "")
    end
  end
end
