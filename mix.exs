defmodule Bamboo.ObanDeliveryStrategy.Mixfile do
  use Mix.Project

  @project_url "https://github.com/KineticCafe/bamboo_oban_delivery_strategy"
  @version "0.0.1"

  def project do
    [
      app: :bamboo_oban_delivery_strategy,
      version: @version,
      elixir: "~> 1.8",
      source_url: @project_url,
      homepage_url: @project_url,
      name: "Bamboo Elastic Email Adapter",
      description: "A Bamboo adapter for the Elastic Email email service",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      dialyzer: [
        plt_apps: [:dialyzer, :elixir, :kernel, :mix, :stdlib],
        ignore_warnings: ".dialyzer_ignore",
        flags: [:unmatched_returns, :error_handling, :underspecs]
      ],
      deps: deps(),
      docs: docs()
    ]
  end

  defp package do
    [
      maintainers: ["Austin Ziegler", "Kinetic Commerce"],
      licenses: ["MIT"],
      links: %{
        "Github" => @project_url,
        "Elastic Email" => "https://elasticemail.com"
      }
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/bamboo_oban_delivery_strategy",
      main: "Bamboo.ObanDeliveryStrategy",
      source_url: @project_url,
      extras: ["README.md", "Changelog.md", "Contributing.md", "Licence.md"]
    ]
  end

  defp deps do
    [
      {:bamboo, "~> 1.0", only: [:dev, :test]},
      {:oban, "~> 2.0", only: [:dev, :test]},
      {:credo, "~> 1.0", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
