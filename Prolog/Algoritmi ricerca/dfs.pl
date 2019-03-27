% depth_search(Soluzione)
% Vicolo cieco? gestione visitati inutile
depth_search(Soluzione) :-
    iniziale(S),
    dfs(S, Soluzione, [S]).

dfs(S, [], _) :- finale(S), !.
dfs(S, [Az|SequenzaAzioni], Visitati) :-
    applicabile(Az, S),
    trasforma(Az, S, S_Nuovo),
    \+member(S_Nuovo, Visitati),
    dfs(S_Nuovo, SequenzaAzioni, [S_Nuovo|Visitati]).