defmodule ProjectPruebaBackend.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjectPruebaBackendWeb.Telemetry,
      ProjectPruebaBackend.Repo,
      {Redix, name: :redix, host: "127.0.0.1", port: 6379},
      {DNSCluster, query: Application.get_env(:project_prueba_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProjectPruebaBackend.PubSub},
      # Start a worker by calling: ProjectPruebaBackend.Worker.start_link(arg)
      # {ProjectPruebaBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjectPruebaBackendWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectPruebaBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjectPruebaBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
