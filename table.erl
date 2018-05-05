-module(table).
-export([start/0]).

start() -> 
	F1 = fork:start(),
	F2 = fork:start(),
	F3 = fork:start(),
	F4 = fork:start(),
	F5 = fork:start(),

	P1 = philosopher_1:start(F5, F1),
	P2 = philosopher_1:start(F1, F2),
	P3 = philosopher_1:start(F2, F3),
	P4 = philosopher_1:start(F3, F4),
	P5 = philosopher_1:start(F4, F5).
