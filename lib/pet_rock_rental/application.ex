defmodule PetRockRental.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PetRockRentalWeb.Telemetry,
      PetRockRental.Repo,
      {DNSCluster, query: Application.get_env(:pet_rock_rental, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PetRockRental.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PetRockRental.Finch},
      # Start a worker by calling: PetRockRental.Worker.start_link(arg)
      # {PetRockRental.Worker, arg},
      # Start to serve requests, typically the last entry
      PetRockRentalWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetRockRental.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PetRockRentalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
