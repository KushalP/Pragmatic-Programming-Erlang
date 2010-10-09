-module(lib_misc).
-export([
	sum/1,
	sum/2,
	for/3,
	qsort/1,
	pythag/1,
	perms/1
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

qsort([]) ->
	[];
qsort([Pivot|T]) ->
	qsort([X || X <- T, X < Pivot])
	++ [Pivot] ++
	qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
	[ {A, B, C} ||
		% list:seq(1, N) returns a list of all the
		% integers from 1 to N. Thus, the below means
		% that A takes all possible values from 1 to N.
		A <- lists:seq(1, N),
		B <- lists:seq(1, N),
		C <- lists:seq(1, N),
		A + B + C =< N,
		A * A + B * B =:= C * C
	].

% Produces typed permutations of what it's given. Perfect
% for funding anagrams or creating string permutations.
perms([]) ->
	[[]];
perms(L) ->
	[[H|T] || H <- L, T <- perms(L--[H])].
