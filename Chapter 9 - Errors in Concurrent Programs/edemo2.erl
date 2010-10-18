-module(edemo2).
-export([start/2]).

%% test exit(B, Why)
start(Bool, M) ->
    %% Spawn three process A B and C
    A = spawn(fun() -> a() end),
    B = spawn(fun() -> b(A, Bool) end),
    C = spawn(fun() -> c(B, M) end),
    sleep(1000),
    status(a, A),
    status(b, B),
    status(c, C).

a() ->      
    process_flag(trap_exit, true),
    wait(a).

b(A, Bool) ->
    process_flag(trap_exit, Bool),
    link(A),
    wait(b).

c(B, M) ->
    process_flag(trap_exit, true),
    link(B),
    exit(B, M),
    wait(c).


wait(Prog) ->
    receive
        Any ->
            io:format("Process ~p received ~p~n",[Prog, Any]),
            wait(Prog)
    end.

sleep(T) ->
    receive
    after T -> true
    end.

status(Name, Pid) ->	    
    case process_info(Pid) of
        undefined ->
            io:format("process ~p (~p) is dead~n", [Name,Pid]);
        _ ->
            io:format("process ~p (~p) is alive~n", [Name, Pid])
    end.
