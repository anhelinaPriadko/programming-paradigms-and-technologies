non_terminal(s).
non_terminal(a).

terminal(x).
terminal(y).
terminal(z).
terminal(b).

rule(s, [x, a]).
rule(s, [b]).

# rule(a, [x, s]).
rule(a, [z, a, a]).
rule(s, [y, x]).

has_duplicates([H|T]) :- member(H, T), !.
has_duplicates([_|T]) :- has_duplicates(T).

check_non_terminal(NT) :-
    findall(First, (rule(NT, [First|_])), FirstSymbols),
    
    forall(member(S, FirstSymbols), terminal(S)),
    
    \+ has_duplicates(FirstSymbols).

is_korenyak_hopcroft :-
    forall(non_terminal(NT), check_non_terminal(NT)).

run_task :-
    (is_korenyak_hopcroft ->
        format('--- Результат перевірки ---~n', []),
        format('Граматика ВІДПОВІДАЄ умовам Кореняка-Хопкрофта.~n', [])
    ;
        format('--- Результат перевірки ---~n', []),
        format('Граматика НЕ відповідає умовам (є однакові початкові термінали або правила починаються з нетерміналів).~n', [])
    ).