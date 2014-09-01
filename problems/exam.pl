p(L, M) :-
  subset(M, L),
  ps(L, M, L).

ps([H|T], M, B) :-
  stanislav(H, M, B),
  ps(T, M, B).

ps([], _, _).

stanislav(A, [H|T], B) :-
  HD is A-H,
  member(HD, B),
  HA is A+H,
  member(HA, B),
  HE is A*H,
  member(HE, B);
  stanislav(A, T, B).

stanislav(_, [], _) :- false.

member(E, [E|_]).
member(E, [_|T]) :-
  member(E, T).
member(_, []) :- false.

subset([H|T], [HB|TB]) :-
  member(H, [HB|TB]),
  subset(T, TB).

subset([], []).
subset(_, []) :- false.





