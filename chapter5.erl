-module(chapter5).
-export([map_search_pred/2]).

map_search_pred(Map, Pred) ->
    msp(maps:to_list(Map), Pred).
    
msp([{K, V}|L], Pred) ->
  case Pred(K, V) of 
      true -> {ok, {K, V}};
      false -> msp(L, Pred)
  end;
msp([], Pred) -> {nok, {}}.
