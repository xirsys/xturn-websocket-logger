defmodule XTurn.WebSocketLoggerTest do
  use ExUnit.Case
  doctest XTurn.WebSocketLogger

  test "greets the world" do
    assert XTurn.WebSocketLogger.hello() == :world
  end
end
