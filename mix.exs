defmodule Budgie.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      name: "budgie.api",
      apps_path: "apps",
      version: @version,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.16", only: [:test]},
      {:credo, "~> 1.7", only: [:dev, :test]}
    ]
  end
end
