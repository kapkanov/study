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

until([], _) ->
  [];
until(Head, 0) ->
  [];
until([Head | Rest], Count) ->
  [Head | until(Rest, Count - 1)].

% Starting from 0, index Count is included
rest(List, 0) ->
  List;
rest([], _) ->
  [];
rest([Head | Rest], Count) ->
  rest(Rest, Count - 1).

% Starting from 0
setcol([], _, Value) ->
  [];
setcol(Str, 0, Value) ->
  Str;
setcol(Str, Column, Value) ->
  Before     = until(Str, Column),
  [_ | Rest] = rest(Str, Column),
  After      = [Value | Rest],
  lists:merge(Before, After).

setcell(List, Row, Column, Value) ->
  Before        = until(List, Row),
  [Head | Rest] = rest(List, Row),
  Changed       = [setcol(Head, Column, Value)],
  lists:merge(lists:merge(Before, Changed), Rest).

start() ->
  {ok, Bin} = file:read_file("test.txt"),
  Str       = case unicode:characters_to_list(Bin) of
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

  Path       = genpath(Rows, Columns),
  io:format("Path = ~p~n~n", [Path]),

  Row        = getrow(List, 3),
  Col        = getcol(Row, 6),
  io:format("List = ~p~n", [List]),
  io:format("Row  = ~p~n", [Row]),
  io:format("Col  = ~c~n", [Col]),
  io:format("Get  = ~c~n", [getcell(List, 3, 6)]),
  io:format("genrow(10)  = ~p~n", [genrow(10)]),
  io:format("genpath(3,4)  = ~p~n", [genpath(3, 4)]),
  io:format("listlen(List)  = ~p~n", [listlen(List)]),

  io:format("setcol(\"123456\", 3, $9) = ~p~n", [setcol("123456", 3, $9)]),

  io:format("until(\"123456\", 3)  = ~p~n", [until("12345678", 3)]),
  io:format("until([\"123\",\"456\",\"hola\"], 2)  = ~p~n", [until(["123","456","hola"], 2)]),
  io:format("getrow([\"123\",\"456\",\"hola\"], 2)  = ~p~n", [getrow(["123","456","hola"], 2)]),

  io:format("setcell([[1,2,3],[4,5,6],[7,8,9]], 1, 1, 11) = ~p~n", [setcell([[1,2,3],[4,5,6],[7,8,9]], 1, 1, 11)]),

  io:format("rest([1,2,3,4,5,6], 4) = ~p~n", [rest([1,2,3,4,5,6], 4)]).
