defmodule Core.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :rest_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
