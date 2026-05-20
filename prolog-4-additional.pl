rule('S', [a, 'A', b]).
rule('S', [b, 'S']).
rule('A', [c, 'A']).
rule('A', [d, 'S', d]).
rule('A', [a]).

non_terminals(['S', 'A']).

step([U, A, V], [NewU, NextNonTerminal, NewV], StepLen) :-
    rule(A, RHS),
    append(LeftTerminals, [NextNonTerminal|RightTerminals], RHS),
    non_terminals(NTList), member(NextNonTerminal, NTList),
    all_terminals(LeftTerminals),
    all_terminals(RightTerminals),
    append(U, LeftTerminals, NewU),
    append(RightTerminals, V, NewV),
    length(LeftTerminals, L1),
    length(RightTerminals, L2),
    StepLen is L1 + L2.

all_terminals(List) :-
    non_terminals(NTList),
    forall(member(X, List), \+ member(X, NTList)).

derivation(StartNT, TargetNT, U, V, MaxLen) :-
    derivation(StartNT, TargetNT, [], [], 0, MaxLen, U, V).

derivation(TargetNT, TargetNT, AccU, AccV, CurrentLen, MaxLen, AccU, AccV) :-
    CurrentLen > 0,
    CurrentLen =< MaxLen.

derivation(CurrentNT, TargetNT, AccU, AccV, CurrentLen, MaxLen, FinalU, FinalV) :-
    CurrentLen < MaxLen,
    step([AccU, CurrentNT, AccV], [NewU, NextNT, NewV], StepLen),
    NewLen is CurrentLen + StepLen,
    NewLen =< MaxLen,
    derivation(NextNT, TargetNT, NewU, NewV, NewLen, MaxLen, FinalU, FinalV).

solve_for_nt(A, MinLen, Pairs) :-
    between(1, 10, MinLen),
    findall((U_Str, V_Str), 
            ( derivation(A, A, U, V, MinLen),
              string_chars(U_Str, U),
              string_chars(V_Str, V)
            ), 
            RawPairs),
    RawPairs \== [],
    sort(RawPairs, Pairs), !.

print_pairs([]).
print_pairs([(U, V)|Tail]) :-
    format('("~w", "~w")', [U, V]),
    (Tail \== [] -> format(', ', []) ; true),
    print_pairs(Tail).

run_analysis :-
    non_terminals(NTList),
    format('--- АНАЛІЗ МІНІМАЛЬНИХ КОНТЕКСТНИХ ЦИКЛІВ ГРАМАТИКИ ---~n~n', []),
    member(NT, NTList),
    (   solve_for_nt(NT, MinLen, Pairs)
    ->  format('Нетермінал: ~w~n', [NT]),
        format('  minlengthM(~w) = ~w~n', [NT, MinLen]),
        format('  words_minlenM(~w) = [', [NT]),
        print_pairs(Pairs),
        format(']~n~n', [])
    ;   format('Нетермінал: ~w~n', [NT]),
        format('  minlengthM(~w) = не існує (немає контекстних циклів)~n~n', [NT])
    ),
    fail.
run_analysis.