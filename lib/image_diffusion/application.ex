defmodule ImageDiffusion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ImageDiffusionWeb.Telemetry,
      # Start the Ecto repository
      ImageDiffusion.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ImageDiffusion.PubSub},
      # Start Finch
      {Finch, name: ImageDiffusion.Finch},
      # Start the Endpoint (http/https)
      ImageDiffusionWeb.Endpoint
      # Start a worker by calling: ImageDiffusion.Worker.start_link(arg)
      # {ImageDiffusion.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImageDiffusion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ImageDiffusionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
