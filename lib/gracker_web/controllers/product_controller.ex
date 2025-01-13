defmodule GrackerWeb.ProductController do
  alias Gracker.Foodfacts
  alias Gracker.Products.Product
  alias Gracker.Products
  alias Gracker.Products.ProductPrice
  use GrackerWeb, :controller

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  def new(conn, params) do
    changeset = Products.change_product(%Product{})
    stores = Products.list_stores()

    render(conn, :new, changeset: changeset, stores: stores, prepopulated: params[:prepopulated] || %{})
  end

  def create(conn, %{"product" => product_params}) do
    if Map.has_key?(product_params, :photo) do
      with photo <- Map.get(product_params, :photo),
           barcode_jpeg <- File.read!(photo.path),
           {:ok, [%Zbar.Symbol{} = top_symbol | _]} <- Zbar.scan(barcode_jpeg) do
        IO.inspect(top_symbol.data)
      end
    end

    IO.inspect(product_params)

    case Products.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def create_from_bar(conn, %{"product" => product_params}) do
    with %Plug.Upload{} = photo <- Map.get(product_params, "photo"),
         barcode_jpeg <- File.read!(photo.path),
         {:ok, [%Zbar.Symbol{} = top_symbol | _]} <- Zbar.scan(barcode_jpeg) do
      upc = top_symbol.data
      existing_product = Products.get_product_by_upc(upc)
      name = if existing_product, do: existing_product.name, else: Foodfacts.get_foodfacts(upc).name
      conn
      |> put_flash(:info, "Identified UPC #{upc} from that barcode as #{name}!")
      |> new(%{prepopulated: %{name: name, upc: upc}})
    else
      error -> conn |> put_flash(:error, "Failed to parse barcode from image! Error: #{inspect(error)}")
    end
  end

  def price(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    stores = Products.list_stores()

    changeset =
      %ProductPrice{}
      |> ProductPrice.changeset()

    render(conn, :price, product: product, stores: stores, changeset: changeset)
  end

  def add_price(conn, %{"product_price" => product_price_params, "id" => product_id}) do
    params = product_price_params |> Map.put("product_id", product_id)

    with {:ok, _} <- Products.create_product_price(params) do
      conn
      |> put_flash(:info, "price added successfully.")
      |> redirect(to: ~p"/products/#{product_id}")
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    prices = Products.get_product_prices_with_stores(id)
    render(conn, :show, product: product, prices: prices)
  end

  def edit(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    changeset = Products.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    case Products.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end
end
