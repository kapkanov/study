-module(second).
-export([start/0]).

c2i(V) ->
  case V of
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

untilc(Str, C) ->
  untilc(Str, C, []).

untilc([], _, Res) ->
  {reverse(Res), []};
untilc([Head | Rest], C, Res) when Head == C ->
  {reverse(Res), Rest};
untilc([Head | Rest], C, Res) ->
  untilc(Rest, C, [Head | Res]).

reverse(List) ->
  reverse(List, []).

reverse([], Res) ->
  Res;
reverse([Head | Rest], Res) ->
  reverse(Rest, [Head | Res]).

color(Str) ->
  case Str of
    red     ->
      red;
    blue    ->
      blue;
    green   ->
      green;
    "red"   ->
      red;
    "blue"  ->
      blue;
    "green" ->
      green
  end.

split(Str, C) ->
  split(Str, C, []).
split([], _, Res) ->
  reverse(Res);
split(Str, C, Res) ->
  case untilc(Str, C) of
    {[], Rest} ->
      split(Rest, C, Res);
    {Line, []} when Res == [] ->
      Line;
    {Line, Rest} ->
      split(Rest, C, [Line | Res])
  end.

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

addcolor(C, #{red := R, green := G, blue := B}) ->
  case C of
    #{red := Vr, green := Vg, blue  := Vb} ->
      #{red => Vr + R, green => G + Vg, blue => B + Vb};
    #{red   := V} ->
      #{red => R + V, green => G, blue => B};
    #{green := V} ->
      #{red => R, green => G + V, blue => B};
    #{blue  := V} ->
      #{red => R, green => G, blue => B + V}
  end.

parsecolor(Str) ->
  Res      = #{red => 0, green => 0, blue => 0},
  [S1, S2] = split(Str, $ ),
  case isnumber(S1) of
    true  ->
      Res#{color(S2) := s2i(S1)};
    false ->
      Res#{color(S1) := s2i(S2)}
  end.

parsesubset([Head | Rest]) ->
  Res = #{red => 0, green => 0, blue => 0},
  case is_list(Head) of
    true  ->
      parsesubset(split(Head, $,), Res);
    false ->
      parsesubset(split([Head | Rest], $,), Res)
  end.
parsesubset([], Res) ->
  Res;
parsesubset([Head | Rest], Res) ->
  case is_list(Head) of
    true  ->
      parsesubset(Rest, addcolor(parsecolor(Head), Res));
    false ->
      parsesubset([], addcolor(parsecolor([Head | Rest]), Res))
  end.

parseline(Line) ->
  {Game, Rest} = untilc(Line, $:),
  [_, Game_ID] = split(Game, $ ),
  parseline(s2i(Game_ID), parseset(Rest)).
parseline(Game_ID, Set) ->
  {Game_ID, Set}.

parse(Str) ->
  parse(split(crlf2lf(Str), $\n), []).
parse([], Res) ->
  Res;
parse([Head | Rest], Res) ->
  case is_list(Head) of
    true  ->
      parse(Rest, [parseline(Head) | Res]);
    false ->
      parse([], [parseline([Head | Rest]) | Res])
  end.

crlf2lf(Str) ->
  crlf2lf(Str, []).
crlf2lf([], Res) ->
  reverse(Res);
crlf2lf([Head | Rest], Res) when Head == $\r ->
  crlf2lf(Rest, Res);
crlf2lf([Head | Rest], Res) ->
  crlf2lf(Rest, [Head | Res]).

parseset(Str) ->
  parseset(split(Str, $;), []).
parseset([], Res) ->
  Res;
parseset([Head | Rest], Res) ->
  parseset(Rest, [parsesubset(Head) | Res]).

ispossible(#{red := Gr, green := Gg, blue := Gb}, #{red := R, green := G, blue := B}) ->
  if
    Gr =< R andalso Gg =< G andalso Gb =< B ->
      true;
    true ->
      false
  end;
ispossible({Game, []}, _) ->
  Game;
ispossible({Game, [Head | Rest]}, Bag) ->
  case ispossible(Head, Bag) of
    true  ->
      ispossible({Game, Rest}, Bag);
    false ->
      0
  end.
sumpossible([], _) ->
  0;
sumpossible([Head | Rest], Bag) ->
  ispossible(Head, Bag) + sumpossible(Rest, Bag).

maxval(V, W) ->
  if
    W > V ->
      W;
    true ->
      V
  end.
maxmap(#{red := R1, green := G1, blue := B1}, #{red := R2, green := G2, blue := B2}) ->
  #{
     red   => maxval(R1, R2),
     green => maxval(G1, G2),
     blue  => maxval(B1, B2)
   }.

minpossible(Set) ->
  minpossible(Set, #{red => 0, green => 0, blue => 0}).
minpossible([], Res) ->
  Res;
minpossible([Head | Rest], Res) ->
  minpossible(Rest, maxmap(Res, Head)).

power(#{red := R, green := G, blue := B}) ->
  R * G * B;
power(Set) ->
  power(minpossible(Set)).

sumpower([]) ->
  0;
sumpower([{_, Set} | Rest]) ->
  power(Set) + sumpower(Rest).

start() ->
  {ok, Bin} = file:read_file("input"),
  Str = case unicode:characters_to_list(Bin) of
    L when is_list(L) ->
      L;
    _ ->
      binary_to_list(Bin)
   end,
  sumpower(parse(Str)).
  % sumpossible(parse(Str), #{red => 12, green => 13, blue => 14}).

  % minpossible(parseset("3 blue, 4 green; 1 red; 8 green")).

  % sumpower(parse("Game 1: 3 blue, 4 green; 1 red; 8 green")).

  % parse("Game 1: 3 blue, 4 green; 1 red; 8 green").

  % power(minpossible(parseset("3 blue, 4 green; 1 red; 8 green"))).

  % parsesubset("3 blue, 4 red").
  % parseset("3 blue, 4 green; 1 red; 8 green").
  % parse("Game 1: 3 blue, 4 green; 1 red; 8 green\nGame 10: 30 blue, 40 green; 10 red; 80 green").
  % parse("Game 1: 3 blue, 4 green; 1 red; 8 green").
