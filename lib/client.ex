### ----------------------------------------------------------------------
###
### Copyright (c) 2013 - 2018 Lee Sylvester and Xirsys LLC <experts@xirsys.com>
###
### All rights reserved.
###
### XTurn is licensed by Xirsys under the Apache
### License, Version 2.0. (the "License");
###
### you may not use this file except in compliance with the License.
### You may obtain a copy of the License at
###
###      http://www.apache.org/licenses/LICENSE-2.0
###
### Unless required by applicable law or agreed to in writing, software
### distributed under the License is distributed on an "AS IS" BASIS,
### WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
### See the License for the specific language governing permissions and
### limitations under the License.
###
### See LICENSE for the full license text.
###
### ----------------------------------------------------------------------

defmodule Xirsys.XTurn.WebSocketLogger.Client do
  @moduledoc """
  """
  use GenServer
  require Logger
  @vsn "0"
  @stun_marker 0

  alias Xirsys.XTurn.WebSocketLogger.SocketHandler
  alias XMediaLib.Stun

  #########################################################################################################################
  # Interface functions
  #########################################################################################################################

  def start_link(),
    do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  #########################################################################################################################
  # OTP functions
  #########################################################################################################################

  def init(_) do
    Logger.info("Initialising websocket logger")
    {:ok, %{}}
  end

  def handle_cast({:process_message, sender, data}, state) do
    Registry.WebSocketLogger
    |> Registry.dispatch(SocketHandler.key(), fn entries ->
      for {pid, _} <- entries do
        if pid != self() do
          Process.send(pid, parse_msg(data, sender), [])
        end
      end
    end)

    {:noreply, state}
  end

  def terminate(_reason, state) do
    {:ok, state}
  end

  #########################################################################################################################
  # Private functions
  #########################################################################################################################

  defp parse_msg(%Xirsys.Sockets.Conn{
         client_ip: ip,
         client_port: cport,
         message: <<@stun_marker::2, _::14, _rest::binary>> = msg
       }, sender) do
    case Stun.pretty(msg) do
      {:ok, dec_msg} ->
        %{
          type: "stun",
          sender: sender,
          client_ip: parse_ip(ip),
          client_port: cport,
          message: dec_msg
        }
        |> Jason.encode!()

      _ ->
        "Failed to parse message"
    end
  end

  defp parse_msg(%Xirsys.Sockets.Conn{
         client_ip: ip,
         client_port: cport,
         message: <<1::2, _num::14, _length::16, _rest::binary>>
       }, sender),
       do:
         %{
           type: "channel_data",
           sender: sender,
           client_ip: parse_ip(ip),
           client_port: cport
         }
         |> Jason.encode!()

  defp parse_msg(msg, sender) when is_binary(msg), do: "#{sender}: #{inspect msg}"
  defp parse_msg(msg, sender), do: "TODO, #{sender}: #{inspect(msg)}"

  defp parse_ip({i0, i1, i2, i3}), do: "#{i0}.#{i1}.#{i2}.#{i3}"

  defp parse_ip({i0, i1, i2, i3, i4, i5, i6, i7}),
    do: "#{i0}:#{i1}:#{i2}:#{i3}:#{i4}:#{i5}:#{i6}:#{i7}"
end
