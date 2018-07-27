defmodule Computer.MixProject do
  use Mix.Project

  def project do
    [
      app: :computer,
      version: "0.1.0",
      elixir: "~> 1.7-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.9.2"},
      {:hangman, path: "../hangman"},
      {:dictionary, path: "../dictionary"},
    ]
  end
end
