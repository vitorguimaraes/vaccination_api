defmodule VaccinationApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      VaccinationApiWeb.Telemetry,
      # Start the Ecto repository
      VaccinationApi.Repo,
      {Oban, Application.fetch_env!(:vaccination_api, Oban)},
      # Start the PubSub system
      {Phoenix.PubSub, name: VaccinationApi.PubSub},
      # Start Finch
      {Finch, name: VaccinationApi.Finch},
      # Start the Endpoint (http/https)
      VaccinationApiWeb.Endpoint
      # Start a worker by calling: VaccinationApi.Worker.start_link(arg)
      # {VaccinationApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VaccinationApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VaccinationApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
