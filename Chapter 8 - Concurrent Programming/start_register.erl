-module(start_register).
-export([start/2]).

start(Atom, Fun) ->
    Registrant = self(),
    spawn(
        fun() ->
                try register(Atom, self()) of
                    true ->
                        Registrant ! true,
                        Fun()
                catch
                    error:badarg ->
                        Registrant ! false
                end
        end),
    receive
        true ->
            true;
        false ->
            erlang:error(badarg)
    end.
