defmodule GrackerWeb.StoreControllerTest do
  use GrackerWeb.ConnCase

  import Gracker.ProductsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all stores", %{conn: conn} do
      conn = get(conn, ~p"/stores")
      assert html_response(conn, 200) =~ "Listing Stores"
    end
  end

  describe "new store" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/stores/new")
      assert html_response(conn, 200) =~ "New Store"
    end
  end

  describe "create store" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/stores", store: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/stores/#{id}"

      conn = get(conn, ~p"/stores/#{id}")
      assert html_response(conn, 200) =~ "Store #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/stores", store: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Store"
    end
  end

  describe "edit store" do
    setup [:create_store]

    test "renders form for editing chosen store", %{conn: conn, store: store} do
      conn = get(conn, ~p"/stores/#{store}/edit")
      assert html_response(conn, 200) =~ "Edit Store"
    end
  end

  describe "update store" do
    setup [:create_store]

    test "redirects when data is valid", %{conn: conn, store: store} do
      conn = put(conn, ~p"/stores/#{store}", store: @update_attrs)
      assert redirected_to(conn) == ~p"/stores/#{store}"

      conn = get(conn, ~p"/stores/#{store}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, store: store} do
      conn = put(conn, ~p"/stores/#{store}", store: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Store"
    end
  end

  describe "delete store" do
    setup [:create_store]

    test "deletes chosen store", %{conn: conn, store: store} do
      conn = delete(conn, ~p"/stores/#{store}")
      assert redirected_to(conn) == ~p"/stores"

      assert_error_sent 404, fn ->
        get(conn, ~p"/stores/#{store}")
      end
    end
  end

  defp create_store(_) do
    store = store_fixture()
    %{store: store}
  end
end
