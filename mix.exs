defmodule PrettyBoi.MixProject do
  @moduledoc """
  Mix Project
  """

  use Mix.Project

  def project do
    [
      app: :pretty_boi,
      version: "1.0.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        list_unused_filters: true
      ],
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # {:prop_schema, "~> 1.0"},
      # {:jason, "~> 1.0"},
      # {:dark_ecto, "~> 1.0"},

      # Development
      # {:faker, "~> 0.13", only: [:dev, :test]},
      # {:ex_machina, "~> 2.4", only: [:dev, :test]},
      {:dark_dev, ">= 1.0.4", only: [:dev, :test], runtime: false}
    ]
  end
end
