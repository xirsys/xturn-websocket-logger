defmodule XTurn.WebSocketLogger.MixProject do
  use Mix.Project

  def project do
    [
      app: :xturn_websocket_logger,
      version: "0.1.0",
      elixir: "~> 1.7",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Websocket based logging platform for the XTurn server.",
      source_url: "https://github.com/xirsys/xturn-websocket-logger",
      homepage_url: "https://xirsys.github.io/xturn/",
      package: package(),
      docs: [
        extras: ["README.md"],
        main: "readme"
      ]
    ]
  end

  def application do
    [mod: {XTurn.WebsocketLogger, []}, applications: []]
  end

  defp deps do
    []
  end

  defp package do
    %{
      maintainers: ["Jahred Love"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/xirsys/xturn-websocket-logger"}
    }
  end
end