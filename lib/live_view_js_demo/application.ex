defmodule LiveViewJsDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveViewJsDemoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:live_view_js_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveViewJsDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveViewJsDemo.Finch},
      # Start a worker by calling: LiveViewJsDemo.Worker.start_link(arg)
      # {LiveViewJsDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveViewJsDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewJsDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveViewJsDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
