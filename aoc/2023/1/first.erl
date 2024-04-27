-compile(debug_info).
-module(first).
-export([combine/1, s2i/1, c2i/1, calibrate/1, start/0, splitn/1]).

reverse(List) ->
  reverse(List, []).

reverse([], Res) ->
  Res;
reverse([Head | Rest], Res) ->
  reverse(Rest, [Head | Res]).

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

combine([]) ->
  [];
combine([Head | Rest]) ->
  case cmpnum([Head | Rest]) of
    [] ->
      combine(Rest);
    Num ->
      [Num | combine(Rest)]
  end.

cfirst([Head | _]) ->
  Head.

clast(Str) ->
  cfirst(reverse(Str)).

recover(Str) ->
  N = combine(Str),
  s2i([cfirst(N), clast(N)]).

calibrate([]) ->
  0;
calibrate([Cur | Rest]) ->
  io:format("~-55s ~p~n", [Cur, recover(Cur)]),
  recover(Cur) + calibrate(Rest).

append(List, []) ->
  List;
append([], Item) ->
  [Item];
append([Head | Rest], Item) ->
  if
    Rest == [] ->
      [Item, Head];
    true ->
      [Item | [Head | Rest]]
  end.

untiln(Str) ->
  untiln(Str, []).

untiln([], Str) ->
  {reverse(Str), []};
untiln([C | Rest], Str) when   C == '\n' orelse C == '\r'
                        orelse C == $\n  orelse C == $\r ->
  {reverse(Str), Rest};
untiln([C | Rest], Str) ->
  untiln(Rest, [C | Str]).

splitn(Str) ->
  reverse(splitn(Str, [])).

splitn([], Res) ->
  Res;
splitn(Str, Res) ->
  {Line, Rest} = untiln(Str),
  if
    Line == [] ->
      splitn(Rest, Res);
    true ->
      splitn(Rest, append(Res, Line))
  end.

cmp([], []) ->
  true;
cmp(_, []) ->
  true;
cmp([], _) ->
  false;
cmp([Head1 | Rest1], [Head2 | Rest2]) ->
  if
    Head1 == Head2 ->
      cmp(Rest1, Rest2);
    true ->
      false
  end;
cmp(_, _) ->
  false.

shift([], _) ->
  [];
shift(List, 0) ->
  List;
shift([Head | Rest], Count) ->
  shift(Rest, Count - 1).

cmpnum(Str) ->
  One           = cmp(Str, "one"),
  Two           = cmp(Str, "two"),
  Three         = cmp(Str, "three"),
  Four          = cmp(Str, "four"),
  Five          = cmp(Str, "five"),
  Six           = cmp(Str, "six"),
  Seven         = cmp(Str, "seven"),
  Eight         = cmp(Str, "eight"),
  Nine          = cmp(Str, "nine"),
  [Head | Rest] = Str,
  if
    Head == $0 orelse Head  == $1 orelse Head == $2
               orelse Head  == $3 orelse Head == $4
               orelse Head  == $5 orelse Head == $6
               orelse Head  == $7 orelse Head == $8
               orelse Head  == $9 ->
      Head;
    One   == true ->
      $1;
    Two   == true ->
      $2;
    Three == true ->
      $3;
    Four  == true ->
      $4;
    Five  == true ->
      $5;
    Six   == true ->
      $6;
    Seven == true ->
      $7;
    Eight == true ->
      $8;
    Nine  == true ->
      $9;
    true ->
      []
  end.

start() ->
  % recover("hs1").
  {ok, Bin} = file:read_file("input"),
  List = case unicode:characters_to_list(Bin) of
    L when is_list(L) ->
      L;
    _ ->
      binary_to_list(Bin)
   end,
  calibrate(splitn(List)).

% 54239
