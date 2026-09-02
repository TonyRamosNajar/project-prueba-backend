defmodule ProjectPruebaBackend.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :sku, :string
      add :stock, :integer
      add :price, :float

      timestamps(type: :utc_datetime)
    end
  end
end
