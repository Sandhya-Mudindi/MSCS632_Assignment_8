% ---------------------------
% Basic Gender Definitions
% ---------------------------

male(john).
male(paul).
male(george).
male(david).
male(mike).
male(bob).

female(mary).
female(lisa).
female(anna).
female(jane).
female(susan).
female(emma).

% ---------------------------
% Parent-Child Relationships
% ---------------------------

parent(john, paul).
parent(john, lisa).
parent(mary, paul).
parent(mary, lisa).

parent(paul, george).
parent(paul, anna).
parent(jane, george).
parent(jane, anna).

parent(lisa, david).
parent(lisa, susan).
parent(bob, david).
parent(bob, susan).

parent(george, emma).
parent(emma, mike).

% ---------------------------
% Derived Relationships
% ---------------------------

% Child: Y is a child of X
child(Y, X) :- parent(X, Y).

% Grandparent: X is grandparent of Y
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Sibling: X and Y share a parent and are not the same person
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% Cousin: X and Y have parents who are siblings
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y.

% ---------------------------
% Logical Inference Queries
% ---------------------------

% List of all children for a given parent
children(Parent, ChildrenList) :-
    findall(Child, parent(Parent, Child), ChildrenList).

% List of all siblings of a person (removes duplicates)
siblings(Person, SiblingList) :-
    setof(Sibling, sibling(Person, Sibling), SiblingList), !.
siblings(_, []).  % fallback if no siblings found

% Check if two people are cousins
is_cousin(X, Y) :- cousin(X, Y).

% ---------------------------
% Recursive Descendant Logic
% ---------------------------

% Descendant base case: X is a child of Y
descendant(X, Y) :- parent(Y, X).

% Recursive case: X is descendant of Y through intermediate Z
descendant(X, Y) :- parent(Y, Z), descendant(X, Z).

% Collect all descendants into a list
all_descendants(Person, Descendants) :-
    findall(D, descendant(D, Person), Descendants).
