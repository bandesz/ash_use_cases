defmodule AshUseCases.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AshUseCasesWeb.Telemetry,
      AshUseCases.Repo,
      {DNSCluster, query: Application.get_env(:ash_use_cases, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AshUseCases.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AshUseCases.Finch},
      # Start a worker by calling: AshUseCases.Worker.start_link(arg)
      # {AshUseCases.Worker, arg},
      # Start to serve requests, typically the last entry
      AshUseCasesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AshUseCases.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AshUseCasesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
