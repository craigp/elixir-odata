defmodule OData.Mixfile do
  use Mix.Project

  def project do
    [app: :odata,
     version: "0.1.8",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [
       "coveralls": :test,
       "coveralls.detail": :test,
       "coveralls.post": :test
     ],
     description: "OData for Elixir, or something resembling it",
     package: package()]
  end

  defp deps do
    [
      {:httpoison, "~> 0.10"},
      {:poison, "~> 2.0 or ~> 3.0"},
      {:excoveralls, "~> 0.5", only: :test},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.13", only: :dev},
      {:dialyxir, "~> 0.3", only: :dev},
      {:credo, "~> 0.3", only: :dev},
      {:dogma, "~> 0.1", only: :dev},
      {:bypass, "~> 0.1", only: :test},
      {:inch_ex, "~> 0.5", only: :docs}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      maintainers: ["Craig Paterson"],
      links: %{"Github" => "https://github.com/craigp/elixir-odata"}
    ]
  end

end
