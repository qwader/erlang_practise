-module(math_functions).
-export([even/1, odd/1, filter/2, split1/1, split2/1, my_tuple_to_list/1]).

even(X) -> case X rem 2 of
              1 -> false;
              0 -> true
           end.
           
odd(X)  -> not even(X).

filter(F, L) -> [X || X <- L, F(X)].

split1(L) -> { filter( fun(X) -> even(X) end, L ), filter( fun(X) -> odd(X) end, L ) }.

split2(L) -> split_acc(L, [], []).

split_acc([H|L], Even, Odd) when H rem 2 =:= 0 -> split_acc(L, [H|Even], Odd);
split_acc([H|L], Even, Odd) -> split_acc(L, Even, [H|Odd]);
split_acc([], Even, Odd) -> {lists:reverse(Even), lists:reverse(Odd)}.

my_tuple_to_list(T) -> ttl(tuple_size(T), 1, T, []).

ttl(0, _, _, L) -> lists:reverse(L);
ttl(N, I, T, L) -> ttl(N - 1, I + 1, T, [element(I, T)|L]).

