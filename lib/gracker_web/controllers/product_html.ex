defmodule GrackerWeb.ProductHTML do
  use GrackerWeb, :html

  embed_templates "product_html/*"

  @doc """
  Renders a product form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  def product_form(assigns)

  @doc """
  Renders a QR code form for getting product name / UPC
  """
  def product_qr_form(assigns)
end
