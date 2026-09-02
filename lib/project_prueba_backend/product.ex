defmodule ProjectPruebaBackend.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :sku, :string
    field :stock, :integer
    field :price, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :sku, :stock, :price])
    |> validate_required([:name, :sku, :stock, :price])
  end
end
