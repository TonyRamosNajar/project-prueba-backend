defmodule ProjectPruebaBackend.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectPruebaBackend.Inventory` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: 120.5,
        sku: "some sku",
        stock: 42
      })
      |> ProjectPruebaBackend.Inventory.create_product()

    product
  end
end
