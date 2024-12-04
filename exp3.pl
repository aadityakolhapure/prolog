% Main predicate to solve the problem

% command to run =   find_all_solutions.
eight_queens(Solution) :-
    Solution = [_Q1, _Q2, _Q3, _Q4, _Q5, _Q6, _Q7, _Q8],
    permutation([1, 2, 3, 4, 5, 6, 7, 8], Solution),
    safe(Solution).

% Check that no two queens threaten each other
safe([]).
safe([Q|Others]) :-
    safe(Others),
    no_attack(Q, Others, 1).

% Ensure no two queens are on the same diagonal
no_attack(_, [], _).
no_attack(Q, [Q1|Others], Dist) :-
    abs(Q - Q1) =\= Dist,
    Dist1 is Dist + 1,
    no_attack(Q, Others, Dist1).

% To find all solutions, backtrack over them
find_all_solutions :-
    eight_queens(Solution),
    write(Solution), nl,
    fail. % Force backtracking to get all solutions

% Stop the program gracefully
find_all_solutions :- 
    write('All solutions found.'), nl.
