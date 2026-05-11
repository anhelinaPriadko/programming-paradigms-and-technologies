fact(0, 1) :- !.
fact(N, F) :- N > 0, N1 is N - 1, fact(N1, F1), F is N * F1.

split([], _, []) :- !.
split(L, K, Res) :-
    fact(K, S),
    (   length(L, Len), Len >= S 
    ->  length(P, S), append(P, T, L), K1 is K + 1, split(T, K1, R), Res = [P|R]
    ;   Res = [L]
    ).

solve(L, Res) :- 
    reverse(L, RL), split(RL, 1, Ch), reverse(Ch, RC), maplist(reverse, RC, Res).