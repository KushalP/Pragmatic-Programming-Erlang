-module(attrs).
-vsn(2508).
-author({kushal,pisavadia}).
-purpose("Factorial, Bitches!").
-export([fac/1]).

fac(1) -> 1;
fac(N) -> N * fac(N-1).
