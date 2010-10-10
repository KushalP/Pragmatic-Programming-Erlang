-module(area_server1).  
-export([loop/0, rpc/2]). 

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        Response ->
            Response
    end.

loop() ->
    receive
        {rectangle, Width, Ht} -> 
            io:format("Area of rectangle is ~p~n",[Width * Ht]),
            loop();
        {circle, R} -> 
            io:format("Area of circle is ~p~n", [3.14159 * R * R]),
            loop();
        Other ->
            io:format("I don't know what the area of a ~p is ~n",[Other]),
            loop()
    end.
