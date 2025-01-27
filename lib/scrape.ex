defmodule StopAndShopScraper do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url,
    do: "https://stopandshop.com/product-search/milk?searchRef=recent&semanticSearch=false"

  @impl Crawly.Spider
  def init() do
    [
      start_urls: [
        "https://stopandshop.com/product-search/milk?searchRef=recent&semanticSearch=false"
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, doc} = Floki.parse_document(response.body)

    doc
    |> IO.inspect()
    |> Floki.find("span.product-grid-cell_main-price")
    |> IO.inspect()
    |> hd()
  end
end
