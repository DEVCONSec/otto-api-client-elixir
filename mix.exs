defmodule OttoApiClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :otto_api_client,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.7.0"},
      {:jason, "~> 1.2.2"}
    ]
  end
end
