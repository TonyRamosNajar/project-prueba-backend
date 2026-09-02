defmodule ProjectPruebaBackend.GraphQL.Schema do
  use Absinthe.Schema

  query do
    field :products, list_of(:product) do
      resolve(fn _, _, _ ->
        {:ok, ProjectPruebaBackend.Inventory.list_products()}
      end)
    end
  end

  mutation do
  field :update_product, :product do
    arg :sku, non_null(:string)
    arg :stock, non_null(:integer)

    resolve(fn _parent, %{sku: sku, stock: stock}, _resolution ->
      product =
        ProjectPruebaBackend.Inventory.list_products()
        |> Enum.find(&(&1.sku == sku))

      case product do
        nil ->
          {:error, "Producto no encontrado"}

        product ->
          ProjectPruebaBackend.Inventory.update_product(
            product,
            %{stock: stock}
          )
      end
    end)
  end

  field :create_product, :product do
    arg :name, non_null(:string)
    arg :sku, non_null(:string)
    arg :stock, non_null(:integer)
    arg :price, non_null(:float)

    resolve(fn _parent, args, _resolution ->
      ProjectPruebaBackend.Inventory.create_product(args)
    end)
  end
  end

  object :product do
    field :id, :id
    field :name, :string
    field :sku, :string
    field :stock, :integer
    field :price, :float
  end
end