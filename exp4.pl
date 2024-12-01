% Facts: Define the maze as edges between connected points
connected(a, b).
connected(a, c).
connected(b, d).
connected(c, e).
connected(d, f).
connected(e, f).
connected(e, g).
connected(f, h).
connected(g, h).

% Rule to check if there is a path from Start to Goal
dfs(Start, Goal, Path) :-
    dfs_helper(Start, Goal, [Start], Path).

% Helper predicate for DFS
dfs_helper(Goal, Goal, Visited, Path) :-
    reverse(Visited, Path). % If Goal is reached, return the path

dfs_helper(Current, Goal, Visited, Path) :-
    connected(Current, Next),
    \+ member(Next, Visited), % Avoid revisiting nodes
    dfs_helper(Next, Goal, [Next|Visited], Path).

% Predicate to test the DFS solution
solve_maze(Start, Goal) :-
    dfs(Start, Goal, Path),
    write('Path: '), write(Path), nl.
