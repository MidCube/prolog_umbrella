%start state looks like state(car,car,car,car,car)
%end state looks like state(party,party,party,party,party)

person(andy,1).
person(brenda,2).
person(carl,5).
person(dana,10).

time(walk(P1,P2,_),T):-person(P1,T1),person(P2,T2),T=max(T1,T2).

next(state(car,car,C,D,car),state(party,party,C,D,party),walk(andy,brenda,party)).
next(state(car,B,car,D,car),state(party,B,party,D,party),walk(andy,carl,party)).
next(state(car,B,C,car,car),state(party,B,C,party,party),walk(andy,dana,party)).
next(state(car,B,C,D,car),state(party,B,C,D,party),walk(andy,andy,party)).

next(state(A,car,C,D,car),state(A,party,C,D,party),walk(brenda,brenda,party)).
next(state(A,car,car,D,car),state(A,party,party,D,party),walk(brenda,carl,party)).
next(state(A,car,C,car,car),state(A,party,C,party,party),walk(brenda,dana,party)).

next(state(A,B,car,D,car),state(A,B,party,D,party),walk(carl,carl,party)).
next(state(A,B,car,car,car),state(A,B,party,party,party),walk(carl,dana,party)).

next(state(A,B,C,car,car),state(A,B,C,party,party),walk(dana,dana,party)).

% next(state(party,party,C,D,party),state(car,car,C,D,car),walk(andy,brenda,car)).

% next(state(party,B,party,D,party),state(car,B,car,D,car),walk(andy,carl,car)).
%
% next(state(party,B,C,party,party),state(car,B,C,car,car),walk(andy,dana,car)).
%
next(state(party,B,C,D,party),state(car,B,C,D,car),walk(andy,andy,car)).

next(state(A,party,C,D,party),state(A,car,C,D,car),walk(brenda,brenda,car)).
% next(state(A,party,party,D,party),state(A,car,car,D,car),walk(brenda,carl,car)).
%
% next(state(A,party,C,party,party),state(A,car,C,car,car),walk(brenda,dana,car)).
%

next(state(A,B,party,D,party),state(A,B,car,D,car),walk(carl,carl,car)).
% next(state(A,B,party,party,party),state(A,B,car,car,car),walk(carl,dana,car)).
%

next(state(A,B,C,party,party),state(A,B,C,car,car),walk(dana,dana,car)).

start(state(car,car,car,car,car)).
finish(state(party,party,party,party,party)).

search(EndState,EndState,_,[],0).
search(A,B,PreviouslyVisited,[Move|Moves],Time):-
    next(A,C,Move),
    \+member(C,PreviouslyVisited),
    time(Move,T),
    search(C,B,[C|PreviouslyVisited],Moves,TRest),
    Time is T+TRest.

umbrella(Moves,Time) :- start(A),finish(B),search(A,B,[A|[]],Moves,Time).
