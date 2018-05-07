-module(table).
-export([start/0]).

start() -> 
	F1 = fork:start(),
	F2 = fork:start(),
	F3 = fork:start(),
	F4 = fork:start(),
	F5 = fork:start(),

	P1 = philosopher:start(F1, F2),
	P2 = philosopher:start(F2, F3),
	P3 = philosopher:start(F3, F4),
	P4 = philosopher:start(F4, F5),
	P5 = philosopher:start(F1, F5).
