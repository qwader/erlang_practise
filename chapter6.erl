-module(chapter6).
-export([revert/1, revertall/1]).
-export([revertbits/1]).

revert(Bin) ->
	X = checkNative(),
	case X of
		little -> revert(Bin, big, []);
		big -> revert(Bin, little, [])
	end.

revertall(Bin) ->
	X = checkNative(),
	case X of	
		little -> revertall(Bin, big);
		big -> revertall(Bin, little)
	end.
	
revertall( << H/binary >>, little ) -> << H/binary-little >>;
revertall( << H/binary >>, big ) -> << H/binary-big >>.
	
revert( << H:32, B/binary >>, End, L) -> revert(B, End, [ revert32(H, End) | L ]);
revert( << H:16, B/binary >>, End, L ) -> revert(B, End, [ revert16(H, End) | L ]);
revert( << H >>, End, L ) -> revert( << >>, End, [H | L]);
revert( << >>, _, L) -> list_to_binary( lists:reverse(L) ).

revert32(H, End) ->
		case End of 
			little -> << H:32/little >>;
			big -> << H:32/big >> 
		end.
		
revert16(H, End) ->
		case End of
			little -> << H:16/little >>;
			big -> << H:16/big >>
		end.

checkNative() ->
	if 
		<< 16#1234:16 >> =:= << 16#1234/little >>  ->
			little;
		true ->
			big
	end.
		
revertbits(Bin) ->
	<< << ( (X+1) rem 2):1>> ||  <<X:1>> <= Bin >>.
	
	
