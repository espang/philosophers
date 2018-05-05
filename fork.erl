-module(fork).
-export([start/0, loop/2]).


start() -> spawn(fork, loop, [true, none]).

loop(Available, Owner) ->
	receive
		{Philosoph, pick_up} -> 
			pick_up(Available, Owner, Philosoph);
                {Philosoph, put_down} ->
			put_down(Available, Owner, Philosoph)
	end.
	
pick_up(true, _, Philosoph) -> 
	io:format("fork ~p picked up by ~p~n", [self(), Philosoph]),
	Philosoph ! {self(), ok},
	loop(false, Philosoph);
pick_up(false, Owner, Philosoph) -> 
	Philosoph ! {self(), not_available},
	loop(false, Owner).

put_down(true, _, Philosoph) ->
	io:format("~p tried to put down available fork ~p~n", [Philosoph, self()]),
	loop(true, none);
put_down(false, Owner, Owner) ->
	io:format("fork ~p put down by ~p~n", [self(), Owner]),
        loop(true, none);
put_down(false, Owner, Philosoph) ->
	io:format("~p tried to put down fork ~p held by ~p~n", [Philosoph, self(), Owner]),
	loop(false, Owner).
