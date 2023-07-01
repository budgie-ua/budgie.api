defmodule Jobs.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Oban, Application.fetch_env!(:jobs, Oban)}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Jobs.Supervisor)
  end
end
