% Define the distances between cities
% distance(City1, City2, Distance)
distance(a, b, 10).
distance(a, c, 15).
distance(a, d, 20).
distance(b, c, 35).
distance(b, d, 25).
distance(c, d, 30).

% Ensure the distance is symmetric
distance(X, Y, D) :- distance(Y, X, D).

% Calculate the total distance of a route
route_distance([_], 0).  % A single city, no distance
route_distance([City1, City2|Rest], Distance) :-
    distance(City1, City2, Dist),
    route_distance([City2|Rest], RestDistance),
    Distance is Dist + RestDistance.

% Generate all possible permutations of a list
permute([], []).
permute(List, [Head|Tail]) :-
    select(Head, List, Rest),
    permute(Rest, Tail).

% Solve the TSP by finding the shortest route
solve_tsp(Cities, BestRoute, BestDistance) :-
    permute(Cities, BestRoute),
    route_distance(BestRoute, BestDistance).

% Example query to solve the TSP
solve :-
    Cities = [a, b, c, d],  % List of cities
    solve_tsp(Cities, BestRoute, BestDistance),
    write('Best route: '), write(BestRoute), nl,
    write('Best distance: '), write(BestDistance), nl.
