% Main predicate to solve the problem
eight_queens(Solution) :-
    Solution = [Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8],
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

% Stop the program when finished
find_all_solutions :- halt.