defmodule ProjectPruebaBackendWeb.PageController do
  use ProjectPruebaBackendWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
