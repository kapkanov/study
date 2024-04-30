% Message passing utility.

% User interface:

% logon(Name)
% One user at a time can log in from each Erlang node in the
% system messenger: and choose a suitable Name. If the Name
% is already logged in at another node or if someone else is
% already logged in at the same node, login will be rejected
% with a suitable error message.

% logoff()
% Logs off anybody at that node

% message(ToName, Message)
% sends Message to ToName. Error messages if the user of this
% function is not logged on or if ToName is not logged on at
% any node.

% One node in the network of Erlang nodes runs a server which maintains
% data about the logged on users. The server is registered as "messenger"
% Each node where there is a user logged on runs a client process registered
% as "mess_client"
%
% Protocol between the client processes and the server
% ----------------------------------------------------
%
% To server: {ClientPid, logon, UserName}
% Reply {messenger, stop, user_exists_at_other_node} stops the client
% Reply {messenger, logged_on} logon was successful
%
% To server: {ClientPid, logoff}
% Reply: {messenger, logged_off}
%
% To server: {ClientPid, logoff}
% Reply: no reply
%
% To server: {ClientPid, message_to, ToName, Message} send a message
% Reply: {messenger, stop, you_are_not_logged_on} stops the client
% Reply: {messenger, receiver_not_found} no user with this name logged on
% Reply: {messenger, sent} Message has been sent (but no guarantee)
%
% To client: {message_from, Name, Message},
%
% Protocol between the "commands" and the client
% ----------------------------------------------
%
% Started: messenger:client(Server_Node, Name)
% To client: logoff
% To client: {message_to, ToName, Message}
%
% Configuration: change the server_node() function to return the
% name of the node where the messenger server runs

-module(messenger).
-export([message_send/2, test/0, test/1, ping/1, ping/2, logoff/0, server_node/0, start_server/0, server_start/0, server_stop/0, userlist/0, server/1, logon/1, await/0]).

server_node() ->
  'a@DESKTOP-2NUBLAF'.

server_start() ->
  register(mess_server, spawn(messenger, server, [#{}])),
  server_started.
start_server() ->
  server_start().

server() ->
  process_flag(trap_exit, true),
  server().

server_stop() ->
  Server = whereis(mess_server),
  case whereis(mess_server) of
    undefined ->
      server_is_already_stopped;
    Server    ->
      Server ! stop,
      server_stopped
  end.

userlist() ->
  Server = whereis(mess_server),
  Server ! {self(), list},
  receive
    {Server, Usermap} ->
      Usermap
  end.

server_logon(Usermap, From, Name) ->
  case maps:is_key(From, Usermap) of
    true  ->
      From ! {messenger, stop, user_exists_at_other_node},
      Usermap;
    false ->
      From ! {messenger, logged},
      maps:put(From, Name, Usermap)
  end.

is_logged(Usermap, Name) ->
  Keys   = maps:keys(Usermap),
  Filter = fun (K) ->
             Name == maps:get(K, Usermap)
           end,
  Filtered = lists:filtermap(Filter, Keys),
  case length(Filtered) of
    0 ->
      false;
    _ ->
      [Head | _] = Filtered,
      {true, Head}
  end.

server(Usermap) ->
  receive
    {From, ping} ->
      From ! pong,
      server(Usermap);
    {'EXIT', From, _} ->
      to_do_delete_user;
    {From, list} ->
      From ! {self(), Usermap},
      server(Usermap);
    stop ->
      exit(normal);
    {From, message_to, ToName, Message} ->
      case is_logged(Usermap, ToName) of
        false ->
          From ! {messenger, receiver_not_found};
        {true, ToPid} ->
          io:format("ToPid = ~p~n", [ToPid]),
          From ! {messenger, sent},
          ToPid ! {message_from, From, Message}
      end,
      server(Usermap);
    {From, logon, Name} ->
      server(server_logon(Usermap, From, Name));
    {From, logoff} ->
      case maps:is_key(From, Usermap) of
        true  ->
          From ! {messenger, logged_off},
          server(maps:remove(From, Usermap));
        false ->
          server(Usermap)
      end
  end.

message_send(ToName, Message) ->
  case whereis(mess_client) of
    undefined ->
      you_are_not_logged_on;
    Pid ->
      {mess_server, server_node()} ! {self(), message_to, ToName, Message},
    receive
      {messenger, sent} ->
        mess_client ! {message_from, Pid, "Message"};
      {messenger, receiver_not_found} ->
        receiver_not_found
    end
  end.

await() ->
  receive
    {From, logoff} ->
      From ! logged_off,
      exit(normal);
    {From, ping} ->
      From ! pong;
    {message_from, Name, Message} ->
      io:format("Message from ~p: ~p~n", [Name, Message])
  after 3000 ->
      io:format("exit due timeout~n", []),
      exit(timeout)
  end,
  await().

logoff() ->
  mess_client ! {self(), logoff},
  receive
    ok ->
      {mess_server, server_node()} ! {self(), logoff},
      ok
  end.

logon(Name) ->
  case whereis(mess_client) of
    undefined ->
      Pid = spawn(messenger, await, []),
      register(mess_client, Pid),
      {mess_server, server_node()} ! {Pid, logon, Name};
    _ ->
      already_logged
  end.

ping(Name) ->
  Name ! {self(), ping},
  receive
    pong ->
      pong
  end.
ping(Name, Node) ->
  {Name, Node} ! {self(), ping},
  receive
    pong ->
      pong
  end.

test() ->
  test("Dick").

test(Username) ->
  io:format("Start server:~n", []),
  io:format("~p~n~n", [server_start()]),

  io:format("Ping server:~n", []),
  io:format("~p~n~n", [ping(mess_server)]),

  io:format("Send message to Michael~n", []),
  io:format("~p~n~n", [message_send("Michael", "Hola")]),

  io:format("Logon user ~p:~n", [Username]),
  io:format("~p~n~n", [logon(Username)]),

  io:format("Logon ~p:~n", [Username]),
  io:format("~p~n~n", [logon("Username")]),

  io:format("Ping user ~p:~n", [Username]),
  io:format("~p~n~n", [ping(mess_client)]),

  io:format("Send message to ~p:~n", [Username]),
  io:format("~p~n~n", [message_send(Username, "Hola")]),

  io:format("Send message to Abraham:~n", []),
  io:format("~p~n~n", [message_send("Abraham", "Hola")]),

  io:format("Stop server~n", []),
  io:format("~p~n~n", [server_stop()]),

  test_completed.

  % io:format("Send message to Username:~n", []),
  % message_send(),
  % io:format("~n").

  % io:format("Send message:~n"),
  % message_send(),

  % io:format("Logoff user Username:~n"),
  % logoff(),
  % io:format("~n").
