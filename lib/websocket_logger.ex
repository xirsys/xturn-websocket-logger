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

defmodule Xirsys.XTurn.WebSocketLogger.Supervisor do
  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec
    Logger.info("starting auth client")

    children = [
      worker(Xirsys.XTurn.WebSocketLogger.Client, []),
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Xirsys.XTurn.WebSocketLogger.Router,
        options: [
          dispatch: dispatch(),
          port: 4000
        ]
      ),
      Registry.child_spec(
        keys: :duplicate,
        name: Registry.WebSocketLogger
      )
    ]

    opts = [strategy: :one_for_one, name: Xirsys.XTurn.WebSocketLogger]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws/[...]", Xirsys.XTurn.WebSocketLogger.SocketHandler, []},
         {:_, Plug.Cowboy.Handler, {Xirsys.XTurn.WebSocketLogger.Router, []}}
       ]}
    ]
  end
end
