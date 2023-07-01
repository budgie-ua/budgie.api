defmodule Core.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Core.Repo,
      {Finch, name: Core.Finch}
    ]

    opts = [strategy: :rest_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
