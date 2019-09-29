defmodule IntSupport.MixProject do
  use Mix.Project

  def project do
    [
      app: :int_support,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "int_support",
      source_url: "https://gitlab.com/ac.aaroncowan/int_support",
      homepage_url: "https://gitlab.com/ac.aaroncowan/int_support",
      description: description(),
      licenses: ["MIT"],
      links: %{"GitLab" => "https://gitlab.com/ac.aaroncowan/int_support"} 
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
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description() do
    "An Elixir library that is porting Rail's ActiveSupport numeric and integer core extensions."
  end
end
