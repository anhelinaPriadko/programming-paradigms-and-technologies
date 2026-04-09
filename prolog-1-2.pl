
filter_cubes(List, Result) :-
    filter_cubes_recursive(List, 0, 0, Result).


filter_cubes_recursive([], _, _, []).

filter_cubes_recursive([H|T], Index, K, [H|Rest]) :-
    Target is K * K * K,
    Index =:= Target,
    !,
    NextIndex is Index + 1,
    NextK is K + 1,
    filter_cubes_recursive(T, NextIndex, NextK, Rest).

filter_cubes_recursive([_|T], Index, K, Rest) :-
    NextIndex is Index + 1,
    filter_cubes_recursive(T, NextIndex, K, Rest).

run_task(List) :-
    filter_cubes(List, Result),
    format('--- Результат (0-індексація) ---~n', []),
    format('Вхідний список: ~w~n', [List]),
    format('Елементи на позиціях 0, 1, 8...: ~w~n', [Result]).