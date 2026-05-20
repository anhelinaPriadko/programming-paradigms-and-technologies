start_state(q0).
final_state(q4).

transition(q0, a, q0).
transition(q0, b, q1).
transition(q1, b, q1).
transition(q1, a, q2).
transition(q2, a, q2).
transition(q2, b, q3).
transition(q3, b, q3).
transition(q3, a, q4).
transition(q4, a, q4).
transition(q4, b, q4).

accepts(State, State, []).
accepts(FromState, ToState, [Head|Tail]) :-
    transition(FromState, Head, NextState),
    accepts(NextState, ToState, Tail).

solve(V, W, X, FullWord) :-
    start_state(Start),
    final_state(Final),
    
    between(0, 10, L), 
    length(X, L), 

    append(V, X, Part1),
    append(Part1, W, Part2),
    append(Part2, X, FullWord),
    accepts(Start, Final, FullWord).

run_task(V_Str, W_Str) :-
    string_chars(V_Str, V),
    string_chars(W_Str, W),
    (   solve(V, W, X, FullWord)
    ->  string_chars(X_Str, X),
        string_chars(FullWord_Str, FullWord),
        format('ТАК, автомат допускає таке слово!~n', []),
        format('Задане v: "~w"~n', [V_Str]),
        format('Задане w: "~w"~n', [W_Str]),
        format('Знайдене x: "~w"~n', [X_Str]),
        format('Повне слово (v*x*w*x): "~w"~n', [FullWord_Str])
    ;   format('НІ, для заданих v та w такого слова x не існує.~n', [])
    ).