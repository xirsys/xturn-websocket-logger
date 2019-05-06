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

  def handle_cast({:process_message, data}, state) do
    {:noreply, state}
  end

  def terminate(_reason, state) do
    {:ok, state}
  end
end
