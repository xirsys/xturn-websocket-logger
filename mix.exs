defmodule XTurn.WebSocketLogger.MixProject do
  use Mix.Project

  def project do
    [
      app: :xturn_websocket_logger,
      version: "0.1.0",
      elixir: "~> 1.6.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Websocket based logging platform for the XTurn server.",
      source_url: "https://github.com/xirsys/xturn-websocket-logger",
      homepage_url: "https://xturn.me",
      package: package(),
      docs: [
        extras: ["README.md", "LICENSE"],
        main: "readme"
      ]
    ]
  end

  def application do
    [mod: {Xirsys.XTurn.WebSocketLogger.Supervisor, []}, extra_applications: [:logger]]
  end

  defp deps do
    [
      {:cowboy, "~> 2.4"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:gproc, "~> 0.8.0"}
    ]
  end

  defp package do
    %{
      maintainers: ["Jahred Love"],
      licenses: ["Apache 2.0"],
      organization: ["Xirsys"],
      links: %{"Github" => "https://github.com/xirsys/xturn-websocket-logger"}
    }
  end
end
