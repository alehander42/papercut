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










