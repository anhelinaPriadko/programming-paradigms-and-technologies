all_states([q0, q1, q2, q3, q4]).

final_state(q4).

transition(q0, a, q1).
transition(q1, b, q2).
transition(q3, c, q4).
transition(q2, d, q2).

can_reach_final(State, _) :-
    final_state(State).


can_reach_final(State, Visited) :-
    transition(State, _, Next),
    \+ member(Next, Visited),
    can_reach_final(Next, [State|Visited]).

is_productive(State) :-
    can_reach_final(State, []).

run_task :-
    all_states(States),
    findall(S, (member(S, States), is_productive(S)), Productive),
    findall(S, (member(S, States), \+ is_productive(S)), Unproductive),

    format('--- Аналіз скінченого автомату ---~n', []),
    format('Усі стани: ~w~n', [States]),
    format('Продуктивні стани: ~w~n', [Productive]),
    format('Непродуктивні стани: ~w~n', [Unproductive]).