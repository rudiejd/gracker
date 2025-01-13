defmodule Gracker.Foodfacts do
@open_food_api_url "https://world.openfoodfacts.org/api"
  defstruct [:product_name]

  def get_foodfacts(upc) do
    case Req.get("#{@open_food_api_url}/v0/products/#{upc}") do
      {:ok, %Req.Response{status: 200, body: %{product: %{product_name: name}}}} -> {:ok, %Gracker.Foodfacts{product_name: name}}
      {:ok, %Req.Response{status: 200, body: %{product: %{product_name_en: name}}}} -> {:ok, %Gracker.Foodfacts{product_name: name}}
      {:ok, %{status: 200, body: %{product: _}}} -> {:error, "Got 200 from Open Food Facts API, but could not parse response"}
      {:ok, %{status: status} = res} -> {:error, "Received response #{Jason.encode(res.body)} from Open Food Facts API"}
      {:error, ex} when is_exception(ex) -> {:error, "Received exception #{Exception.message(ex)}"}
      _ -> {:error, "Received unexpected response when getting food facts"}
    end
  end

end
