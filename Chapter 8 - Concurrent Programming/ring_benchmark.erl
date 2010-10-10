-module(ring_benchmark).
-export([start/2]).

start(Rounds, Size) ->
    %% Set up a ring of Size - 1, because self() will be counted!
    Ring = ring(Size - 1, self()),
    statistics(runtime),
    %% Send the ping into the ring.
    Ring ! {ping, Rounds},
    %% Put myself into the ring.
    main(Ring),
    {_, Runtime} = statistics(runtime),
    io:format("Ringing ~p messages took ~p milliseconds~n",
        [Rounds * Size, Runtime]).

%% Make a new ring, with a Jeweler at the top
ring(1, Jeweler) ->
    spawn(fun() ->
                proc(1, Jeweler)
        end);
ring(N, Jeweler) ->
    spawn(fun() ->
                proc(N, ring(N - 1, Jeweler))
        end).

%% Proc is a process in the ring.
%% N is its number in the ring,
%% Next is the next process.
%% THINK: linked-lists.
proc(N, Next) ->
    receive
        %% M is the message number.
        {ping, M} ->
            %% Propagate the message.
            Next ! {ping, M},
            if
                M > 1 ->
                    %% Expect more messages.
                    proc(N, Next);
                %% We're done.
                true -> ready
            end
    end.

%% Similar to proc, decrements message number.
%% Returns when all messages sent.
main(Next) ->
    receive
        {ping, M} ->
            if
                M > 1 ->
                    Next ! {ping, M - 1},
                    main(Next);
                true -> ready
            end
    end.
