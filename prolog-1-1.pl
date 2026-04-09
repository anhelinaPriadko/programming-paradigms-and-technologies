remove_n_smallest(List, N, Result) :-
    msort(List, Sorted),
    take(N, Sorted, Smallest),
    subtract_list(List, Smallest, Result).

take(0, _, []) :- !.
take(N, [H|T], [H|R]) :- N > 0, N1 is N - 1, take(N1, T, R).
subtract_list(L, [], L).
subtract_list(L, [H|T], R) :- delete_one(H, L, L1), subtract_list(L1, T, R).
delete_one(X, [X|T], T) :- !.
delete_one(X, [H|T], [H|R]) :- delete_one(X, T, R).

run_task(List, N) :-
    remove_n_smallest(List, N, Result),
    format('--- Результат виконання ---~n', []),
    format('Початковий список: ~w~n', [List]),
    format('Кількість елементів для видалення: ~d~n', [N]),
    format('Оновлений список: ~w~n', [Result]).