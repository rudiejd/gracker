defmodule GrackerWeb.StoreControllerTest do
  use GrackerWeb.ConnCase

  import Gracker.ProductFixtures

  alias Gracker.Product.Store

  @create_attrs %{
    name: "some name",
    address: "some address"
  }
  @update_attrs %{
    name: "some updated name",
    address: "some updated address"
  }
  @invalid_attrs %{name: nil, address: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stores", %{conn: conn} do
      conn = get(conn, ~p"/api/stores")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create store" do
    test "renders store when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/stores", store: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/stores/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some address",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/stores", store: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update store" do
    setup [:create_store]

    test "renders store when data is valid", %{conn: conn, store: %Store{id: id} = store} do
      conn = put(conn, ~p"/api/stores/#{store}", store: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/stores/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, store: store} do
      conn = put(conn, ~p"/api/stores/#{store}", store: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete store" do
    setup [:create_store]

    test "deletes chosen store", %{conn: conn, store: store} do
      conn = delete(conn, ~p"/api/stores/#{store}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/stores/#{store}")
      end
    end
  end

  defp create_store(_) do
    store = store_fixture()
    %{store: store}
  end
end
