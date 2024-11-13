defmodule GrackerWeb.PageController do
  use GrackerWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  # display the prices of every product by UPC by month
  def prices(conn, _params) do
    html(conn, "prices go here")
  end

  def price_drilldown(conn, %{"upc" => upc}) do
    html(conn, "Price drilldown for UPC #{upc}")
  end

  def hello(conn, _params) do
    html(conn, "hello, world!")
  end
end
