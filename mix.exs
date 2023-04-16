defmodule Budgie.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      name: "budgie.api",
      apps_path: "apps",
      version: @version,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test]}
    ]
  end
end
