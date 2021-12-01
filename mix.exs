defmodule Aoc2021.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc2021,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      name: "Advent Of Code 2021",
      source_url: "https://github.com/rhbvkleef/aoc2021",

      docs: [
        source_ref: "master",
        extras: ["README.md"]
      ],

      dialyzer: [
        plt_add_deps: :transitive
      ],
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
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
    ]
  end
end
