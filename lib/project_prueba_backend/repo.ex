defmodule ProjectPruebaBackend.Repo do
  use Ecto.Repo,
    otp_app: :project_prueba_backend,
    adapter: Ecto.Adapters.Postgres
end
