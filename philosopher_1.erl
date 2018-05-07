-module(philosopher_1).
-export([start/2, loop/2]).


start(Left, Right) ->
	spawn(philosopher_1, loop, [Left, Right]).

loop(Left, Right) ->
	think(),
	eat(Left, Right),
	loop(Left, Right).

think() ->
        % rand:seed(),
	% timer:sleep(timer:seconds(rand:uniform())),
	io:format("Philosopher ~p thought~n", [self()]).

eat(Left, Right) ->
	pick_up(Left),
	pick_up(Right),
	% rand:seed(),
	% timer:sleep(timer:seconds(rand:uniform())),
	io:format("Philosopher ~p ate~n", [self()]),
	put_down(Left),
	put_down(Right).

pick_up(Fork) ->
	Fork ! {self(), pick_up},
	receive 
		{not_available} ->
			pick_up(Fork);
		{ok} ->
			ok;
		{_} ->
			ok
	end.

put_down(Fork) ->
	Fork ! {self(), put_down}.

