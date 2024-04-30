-module(pingpong).
-export([ping/1, pong/0]).

pong() ->
  receive
    {From, ping} ->
      From ! {self(), pong},
      pong()
  end.

ping(Node) ->
  {pong, Node} ! {self(), ping},
  receive
    {From, pong} ->
      {From, pong}
  end.
