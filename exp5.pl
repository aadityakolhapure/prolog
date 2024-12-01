% Facts: Define the graph as edges with their costs
edge(a, b, 1).
edge(a, c, 3).
edge(b, d, 4).
edge(c, d, 2).
edge(c, e, 5).
edge(d, f, 1).
edge(e, f, 3).

% Heuristics (estimated cost to reach the goal)
heuristic(a, 6).
heuristic(b, 4).
heuristic(c, 5).
heuristic(d, 2).
heuristic(e, 3).
heuristic(f, 0). % Goal node has heuristic 0

% Best-First Search (BFS) algorithm
best_first_search(Start, Goal, Path, Cost) :-
    bfs([[Start, 0]], Goal, [], Path, Cost).

% BFS Helper: When the goal is reached
bfs([[Goal, Cost]|_], Goal, Visited, Path, Cost) :-
    reverse([Goal|Visited], Path).

% BFS Helper: Explore nodes
bfs([[Node, Cost]|Queue], Goal, Visited, Path, TotalCost) :-
    findall(
        [NextNode, NewCost],
        (edge(Node, NextNode, StepCost),
         heuristic(NextNode, H),
         NewCost is Cost + StepCost + H,
         \+ member(NextNode, Visited)),
        Children
    ),
    append(Queue, Children, NewQueue),
    sort(2, @=<, NewQueue, SortedQueue), % Sort by estimated cost
    bfs(SortedQueue, Goal, [Node|Visited], Path, TotalCost).

% To test the BFS solution
solve(Start, Goal) :-
    best_first_search(Start, Goal, Path, Cost),
    format('Path: ~w~nTotal Cost: ~w~n', [Path, Cost]).
