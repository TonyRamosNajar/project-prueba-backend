defmodule ProjectPruebaBackendWeb.ProductChannel do
  use ProjectPruebaBackendWeb, :channel

  @impl true
  def join("product:lobby", _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("list_products", _payload, socket) do
    products =
    ProjectPruebaBackend.Inventory.list_products()
    |> Enum.map(fn product ->
      %{
        id: product.id,
        name: product.name,
        sku: product.sku,
        stock: product.stock,
        price: product.price
      }
  end)

  {:reply, {:ok, %{products: products}}, socket}
  end

  @impl true
  def handle_in("product_updated", payload, socket) do
    broadcast(socket, "product_updated", payload)
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (product:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
end
