defmodule ProjectPruebaBackend.Cache do
  def get_products do
    case Redix.command(:redix, ["GET", "products"]) do
      {:ok, nil} ->
        :miss

      {:ok, value} ->
        {:ok, Jason.decode!(value)}
    end
  end

  def put_products(products) do
    Redix.command(:redix, [
      "SET",
      "products",
      Jason.encode!(products)
    ])
  end
end