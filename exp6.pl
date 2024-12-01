% Goal state of the 8-puzzle
goal([1, 2, 3, 4, 5, 6, 7, 8, 0]).

% Heuristic: Manhattan Distance
manhattan(State, Distance) :-
    goal(Goal),
    findall(D, 
        (nth0(I, State, Tile), Tile \= 0, nth0(J, Goal, Tile), manhattan_dist(I, J, D)), 
        Distances),
    sum_list(Distances, Distance).

manhattan_dist(Pos1, Pos2, Distance) :-
    Row1 is Pos1 // 3, Col1 is Pos1 mod 3,
    Row2 is Pos2 // 3, Col2 is Pos2 mod 3,
    Distance is abs(Row1 - Row2) + abs(Col1 - Col2).

% Generate next states by moving the blank (0) up, down, left, or right
move(State, NextState) :-
    nth0(ZeroIndex, State, 0),
    move_blank(ZeroIndex, State, NextIndex),
    swap(ZeroIndex, NextIndex, State, NextState).

% Valid movements within the puzzle bounds
move_blank(ZeroIndex, State, NextIndex) :-
    (NextIndex is ZeroIndex - 3;  % Move up
     NextIndex is ZeroIndex + 3;  % Move down
     NextIndex is ZeroIndex - 1, ZeroIndex mod 3 \= 0;  % Move left
     NextIndex is ZeroIndex + 1, ZeroIndex mod 3 \= 2),
    within_bounds(NextIndex).

% Check if the index is within bounds
within_bounds(Index) :- Index >= 0, Index < 9.

% Swap two elements in the list
swap(I, J, State, NewState) :-
    nth0(I, State, Elem1),
    nth0(J, State, Elem2),
    set(State, I, Elem2, TempState),
    set(TempState, J, Elem1, NewState).

% Replace an element in a list at a given position
set([_|T], 0, Elem, [Elem|T]).
set([H|T], Index, Elem, [H|NewT]) :-
    Index > 0, Index1 is Index - 1,
    set(T, Index1, Elem, NewT).

% Best First Search algorithm
best_first_search(Start, Path) :-
    manhattan(Start, H),
    bfs([[Start, [], H]], Path).

bfs([[Goal, Path, _]|_], FinalPath) :-
    goal(Goal),
    reverse([Goal|Path], FinalPath).

bfs([[State, Path, _]|Rest], FinalPath) :-
    findall([NextState, [State|Path], H],
        (move(State, NextState),
         \+ member(NextState, Path),
         manhattan(NextState, H)),
        Children),
    append(Rest, Children, OpenList),
    sort(3, @=<, OpenList, SortedOpenList),
    bfs(SortedOpenList, FinalPath).

% Example run to solve the 8-puzzle
solve(Start) :-
    best_first_search(Start, Path),
    write('Solution Path: '), nl,
    print_path(Path).

print_path([]).
print_path([State|Rest]) :-
    write(State), nl,
    print_path(Rest).
