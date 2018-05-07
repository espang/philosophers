-module(philosopher).
-export([start/2, loop/3]).


start(Left, Right) ->
	spawn(philosopher, loop, [Left, Right, 0]).

loop(Left, Right, C) ->
	io:format("Philsopher ~p ate ~B times~n", [self(), C]),
	think(),
	eat(Left, Right),
	loop(Left, Right, C+1).

think() ->
	timer:sleep(round(2000 * rand:uniform())).

randomized(R, Left, Right) when R =< 0.5 ->
	try_to_eat(Left,Right);
randomized(_, Left, Right) ->
	try_to_eat(Right, Left).

eat(Left, Right) ->
	randomized(rand:uniform(), Left, Right).

try_to_eat(F1, F2) ->
	ok = wait_and_pick_up(F1),
	Ret = fork_client:pick_up(F2),
        case Ret of
	      	ok ->
			timer:sleep(round(1000 * rand:uniform())),
			fork_client:put_down(F1),
			fork_client:put_down(F2);
		_Other ->
			fork_client:put_down(F1),
			eat(F1, F2)
	end.

wait_and_pick_up(F) ->
	Ret = fork_client:pick_up(F),
	case Ret of
		ok ->
			ok;
		_Other ->
			timer:sleep(10),
			wait_and_pick_up(F)
	end.
