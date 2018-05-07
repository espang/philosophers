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
	
pick_up(true, _Owner, Philosoph) -> 
	Philosoph ! {self(), ok},
	loop(false, Philosoph);
pick_up(false, Owner, Philosoph) -> 
	Philosoph ! {self(), not_available},
	loop(false, Owner).

put_down(true, _Owner, _Philosoph) ->
	loop(true, none);
put_down(false, Owner, Owner) ->
        loop(true, none);
put_down(false, Owner, _Philosoph) ->
	loop(false, Owner).
