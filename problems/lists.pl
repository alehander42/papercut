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








