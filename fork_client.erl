-module(fork_client).
-export([pick_up/1, put_down/1]).

pick_up(Fork) ->
	Fork ! {self(), pick_up},
	receive
		{_From, ok} ->
			ok;
		{_From, not_available} ->
			no_fork
	end.

put_down(Fork) ->
	Fork ! {self(), put_down}.
