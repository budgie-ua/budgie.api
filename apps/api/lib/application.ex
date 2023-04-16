defmodule Api.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Api.Supervisor]
    result = Supervisor.start_link(children, opts)
  end
end
