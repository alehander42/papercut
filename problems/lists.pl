%% Find the last element of a list.
%% ?- my_last(X,[a,b,c,d]).
%% X = d
use_module(library(lists)).

my_last(Element, [_|Tail]) :-
  my_last(Element, Tail).
my_last(Element, [Element]).

%% Find the K'th element of a list.
%% The first element in the list is number 1.
%% ?- element_at(X,[a,b,c,d,e],3).
%% X = c
element_at(Element, [_|Tail], Position) :-
  Previous is Position-1, element_at(Element, Tail, Previous).
element_at(Element, [Element|_], 1).
element_at(_, [], _) :- false.

%% Reverse a list.
reverse([], []).
reverse([A|B], X) :-
  reverse(B, W), append(W, [A], X).

%% Find out whether a list is a palindrome.
is_palyndrome(Tail) :- reverse(Tail, Tail).

%%  Flatten a nested list structure.
flatten([Head|Tail], Flattened) :-
  flatten(Head, FlattenedHead),
  flatten(Tail, FlattenedTail),
  append(FlattenedHead, FlattenedTail, Flattened).
flatten([], []).
flatten(Element, [Element]) :- not(is_list(Element)).

%% Eliminate consecutive duplicates of list elements.
eliminate_cons_duplicates([Head, Head|Tail], List) :-
  eliminate_cons_duplicates([Head|Tail], List).

eliminate_cons_duplicates([Head, Other|Tail], List) :-
  not(Head is Other),
  eliminate_cons_duplicates([Other|Tail], CleanTail),
  append([Head], CleanTail, List).

eliminate_cons_duplicates([Head], [Head]).

eliminate_cons_duplicates([], []).

%% Pack consecutive duplicates of list elements into sublists.
pack_cons([Head|Tail], List) :-
  pack_cons_([Head|Tail], [], List).

pack_cons_([Head|Tail], Packet, List) :-
  b(Packet, Head, C),
  pack_cons_(Tail, C, List).

pack_cons_([], Packet, List) :-
  reverse(Packet, List).


b([[Head|Tail]|List], Head, [[Head, Head|Tail]|List]).
b([[Other|Q]|List], Head, [[Head], Q|List]) :- not(Head is Other).
b([], Head, [[Head]]).

%% Run-length encoding of a list.
run_length(List, A) :-
  pack_cons(List, Pack),
  pack_length(Pack, A).

pack_length([[Element|Elements]|Tail], A) :-
  length([Element|Elements], B),
  pack_length(Tail, TailLength),
  append([[B, Element]], TailLength, A).

pack_length([], []).

%% Drop every N'th element from a list.
drop_n(List, N, A) :-
  drop_next(List, N, 0, A).

drop_next([_|Tail], N, 0, A) :-
  NSub is N - 1,
  drop_next(Tail, N, NSub, DropTail),
  append([], DropTail, A).

drop_next([Head|Tail], N, O, A) :-
  not(O is 0),
  OSub is O - 1,
  drop_next(Tail, N, OSub, DropTail),
  append([Head], DropTail, A).

drop_next([], _, _, []).

%% Extract a slice from a list.
extract([Head|Tail], 1, B, L) :-
  not(B is 0),
  BSub is B - 1,
  extract(Tail, 1, BSub, TailSlice),
  append([Head], TailSlice, L).

extract([_|_], _, 0, []).

extract([_|Tail], A, B, L) :-
  not(A is 1),
  not(B is 0),
  ASub is A-1,
  BSub is B-1,
  extract(Tail, ASub, BSub, L).

extract([], _, _, []).


%%  Create a list containing all integers within a given range.

range(A, B, L) :-
  A < B,
  ANext is A+1,
  range(ANext, B, L2),
  append([A], L2, L).

range(B, B, [B]).

range(A, B, []) :-
  A > B.

%% Generate the combinations of K distinct objects chosen from the N elements of a list
combination(1, [Head|Tail], L) :-
  combination(1, Tail, TL),
  append([[Head]], TL, L).

combination(1, [], []).
combination(0, _, []).

combination(C, [A|B], L) :-
  length([A|B], DL),
  not(C < 2),
  C < DL,
  CD is C-1,
  combination(CD, B, BL),
  combination(C, B, BN),
  multi_append([A], BL, AL),
  append(AL, BN, L).

combination(C, E, [E]) :-
  length(E, EL),
  C = EL.

combination(C, E, []) :-
  length(E, F),
  C > F.

multi_append(L, [Head|Tail], E) :-
  is_list(Head),
  append(L, Head, LHead),
  multi_append(L, Tail, EL),
  append([LHead], EL, E).

multi_append(_, [], []).

zcombination(0,_,[]).
zcombination(K,L,[X|Xs]) :- K > 0,
   el(X,L,R), K1 is K-1, zcombination(K1,R,Xs).

% Find out what the following predicate el/3 exactly does.

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).
