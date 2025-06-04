defmodule WarwavexChan.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WarwavexChan.Repo,
      {DNSCluster, query: Application.get_env(:warwavex_chan, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WarwavexChan.PubSub}
      # Start a worker by calling: WarwavexChan.Worker.start_link(arg)
      # {WarwavexChan.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: WarwavexChan.Supervisor)
  end
end
