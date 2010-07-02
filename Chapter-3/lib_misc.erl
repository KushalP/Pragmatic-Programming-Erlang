-module(lib_misc).
-export([
	sum/1,
	sum/2,
	for/3
]).

sum(L) ->
	sum(L, 0).

sum([], N) ->
	N;
sum([H|T], N) ->
	sum(T, H + N).

for(Max, Max, F) ->
	[F(Max)];
for(I, Max, F) ->
	[F(I) | for(I + 1, Max, F)].
