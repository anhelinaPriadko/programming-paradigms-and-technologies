factorial(0, 1) :- !.
factorial(N, F) :- 
    N > 0, 
    N1 is N - 1, 
    factorial(N1, F1), 
    F is N * F1.


split_at(0, L, [], L) :- !.
split_at(_, [], [], []) :- !.
split_at(N, [H|T], [H|T1], R) :- 
    N > 0, 
    N1 is N - 1, 
    split_at(N1, T, T1, R).

do_split([], _, []) :- !.
do_split(List, K, [Chunk|Rest]) :-
    factorial(K, F),
    split_at(F, List, Chunk, Remaining),
    K1 is K + 1,
    do_split(Remaining, K1, Rest).

split_by_factorial(List, Result) :-
    reverse(List, RevList),
    do_split(RevList, 1, Chunks),
    reverse(Chunks, ReorderedChunks),
    maplist(reverse, ReorderedChunks, Result).

run_task(List) :-
    split_by_factorial(List, Result),
    format('--- Результат розбиття (факторіали) ---~n', []),
    format('Початковий список: ~w~n', [List]),
    format('Результат: ~w~n', [Result]).