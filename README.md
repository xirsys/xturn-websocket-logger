# XTurn WebSocket Logger

Adds a WebSocket hook to the XTurn server that outputs parsed messages.  Useful to debug WebRTC applications.

THIS IS CURRENTLY A WORK IN PROGRESS

## Installation

Add the following to the XTurn `mix.exs` files list of dependencies.

```elixir
def deps do
  [
    ...
    {:xturn_websocket_logger, git: "https://github.com/xirsys/xturn-websocket-logger"}
  ]
end
```

Then, add `:xturn_websocket_logger` to the list of applications.

```elixir
  def application() do
    [
      applications: [:crypto, :sasl, :logger, :ssl, :xmerl, :exts, :xturn_websocket_logger],
```

Finally, in the XTurn `config/config.exs`, add `Xirsys.XTurn.WebSocketLogger.Client` to the `client_hooks` list.