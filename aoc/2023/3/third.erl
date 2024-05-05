-module(third).
-export([start/0]).

rows(List) ->
  count(List, 0).

columns(List) ->
  [Head | _] = List,
  count(Head, 0).

count([], Res) ->
  Res;
count([_ | Rest], Res) ->
  count(Rest, Res + 1).

issymbol(C) when C == $. ->
  false;
issymbol(C) ->
  true.

getrow([], _) ->
  [];
getrow([Head | _], Row) when Row == 0 ->
  Head;
getrow([Head | Rest], Row) ->
  getrow(Rest, Row - 1).

getcol([Head | _], Column) when Column == 0 ->
  Head;
getcol([], Column) ->
  [];
getcol([Head | Rest], Column) ->
  getcol(Rest, Column - 1).

getcell(List, Row, Column) ->
  getcol(getrow(List, Row), Column).

setcell(List, Row, Column, Value) ->

setcell(Res)

% walk(List) ->
%   R = 0,
%   C = 0,
% walk(R, C, Rows, Columns) ->
%   if
%     R < 0 orelse C < 0 orelse R >= rows orelse C >= Columns ->
%       false;
%     true ->
%       true
%   end.

genpath(Rows, Columns) ->
  genpath(Rows, Columns, []).
genpath(0, Columns, Res) ->
  Res;
genpath(Rows, Columns, Res) ->
  genpath(Rows - 1, Columns, [genrow(Columns) | Res]).

genrow(Count) ->
  genrow(Count, []).
genrow(0, Res) ->
  Res;
genrow(Count, Res) ->
  genrow(Count - 1, [0 | Res]).

listlen(Str) ->
  listlen(Str, 0).
listlen([], Res) ->
  Res;
listlen([_ | Rest], Res) ->
  listlen(Rest, Res + 1).

start() ->
  {ok, Bin} = file:read_file("test.txt"),
  Str = case unicode:characters_to_list(Bin) of
    L when is_list(L) ->
      strmod:crlf2lf(L);
    _ ->
      strmod:crlf2lf(binary_to_list(Bin))
  end,
  List       = strmod:split(Str, $\n),
  [Head | _] = List,
  Columns    = listlen(Head),
  Rows       = listlen(List),
  io:format("Columns = ~p~n", [Columns]),
  io:format("Rows = ~p~n", [Rows]),

  Path = genpath(Rows, Columns),
  io:format("Path = ~p~n~n", [Path]),

  Row  = getrow(List, 3),
  Col  = getcol(Row, 6),
  io:format("List = ~p~n", [List]),
  io:format("Row  = ~p~n", [Row]),
  io:format("Col  = ~c~n", [Col]),
  io:format("Get  = ~c~n", [getcell(List, 3, 6)]),
  io:format("genrow(10)  = ~p~n", [genrow(10)]),
  io:format("genpath(3,4)  = ~p~n", [genpath(3, 4)]),
  io:format("listlen(List)  = ~p~n", [listlen(List)]).
