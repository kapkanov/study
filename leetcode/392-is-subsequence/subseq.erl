-module(subseq).
-export([is_subsequence/2]).

is_subsequence(S, T) ->
  Sub = unicode:characters_to_list(S),
  Str = unicode:characters_to_list(T),
  is_subsequence({Str, Sub}).

is_subsequence({_, []}) ->
  true;
is_subsequence({[], _}) ->
  false;
is_subsequence({[Head | Rest], [Cur | Left]}) ->
  case Head == Cur of
    true  ->
      is_subsequence({Rest, Left});
    false ->
      is_subsequence({Rest, [Cur | Left]})
  end.
