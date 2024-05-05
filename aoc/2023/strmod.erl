-module(strmod).
-export([c2i/1,   s2i/1,      until/2,   reverse/1,
         split/2, isnumber/1, crlf2lf/1]).

crlf2lf(Str) ->
  crlf2lf(Str, []).
crlf2lf([], Res) ->
  reverse(Res);
crlf2lf([Head | Rest], Res) when Head == $\r ->
  crlf2lf(Rest, Res);
crlf2lf([Head | Rest], Res) ->
  crlf2lf(Rest, [Head | Res]).

isnumber([]) ->
  false;
isnumber([C | Rest]) ->
  if
    C == $  ->
      isnumber(Rest);
    C >= $0 andalso C =< $9 ->
      true;
    true ->
      false
  end.

c2i(N) ->
  case N of
    $0  -> 0;
    $1  -> 1;
    $2  -> 2;
    $3  -> 3;
    $4  -> 4;
    $5  -> 5;
    $6  -> 6;
    $7  -> 7;
    $8  -> 8;
    $9  -> 9
  end.

s2i(Str) ->
  s2i(Str, 0).
s2i([], Res) ->
  Res;
s2i([Cur | Str], V) ->
  W = 10 * V + c2i(Cur),
  s2i(Str, W).

until(Str, C) ->
  until(Str, C, []).
until([], _, Res) ->
  {reverse(Res), []};
until([Head | Rest], C, Res) when Head == C ->
  {reverse(Res), Rest};
until([Head | Rest], C, Res) ->
  until(Rest, C, [Head | Res]).

reverse(List) ->
  reverse(List, []).
reverse([], Res) ->
  Res;
reverse([Head | Rest], Res) ->
  reverse(Rest, [Head | Res]).

split(Str, C) ->
  split(Str, C, []).
split([], _, Res) ->
  reverse(Res);
split(Str, C, Res) ->
  case until(Str, C) of
    {[], Rest} ->
      split(Rest, C, Res);
    {Line, []} when Res == [] ->
      Line;
    {Line, Rest} ->
      split(Rest, C, [Line | Res])
  end.
