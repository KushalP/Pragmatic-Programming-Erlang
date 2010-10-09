catcher(N) ->
    try generate_exception(N) of
        Val -> {N, normal, Val}
    catch
        throw: X    -> {N, caught, thrown, X};
        exit: X     -> {N, caught, exited, X};
        error: X    -> {N, caught, error, X}
    end.

demo1() ->
    [catcher(I) || I <- [1,2,3,4,5]].

demo2() ->
    [{I, (catch generate_exception(I))} || I <- [1,2,3,4,5]].
