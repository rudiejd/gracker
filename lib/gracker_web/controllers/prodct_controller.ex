defmodule GrackerWeb.ProductController do
  use GrackerWeb, :controller

  def index(conn, _params) do
    html(conn, "prices go here")
  end

  # display the prices of every product by UPC by month
  def new(conn, _params) do
  end

  def show(conn, %{"id" => id}) do
    html(conn, "Price drilldown for UPC #{id}")
  end

  def edit(conn, _params) do
  end

  def update(conn, _params) do
  end

  def delete(conn, _params) do
  end
end
