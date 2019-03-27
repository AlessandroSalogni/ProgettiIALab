% dfs_aux(S,ListaAzioni,Visitati,ProfonditaRaggiunta,Soglia) Visita in profondità con una soglia massima
depth_limit_search(Soluzione, Soglia) :-
  iniziale(S),
  dfs_limit(S, Soluzione, [S], Soglia).

dfs_limit(S, [], _, _) :- finale(S), !.
dfs_limit(S, [Az|SequenzaAzioni], Visitati, Soglia) :-
  Soglia > 0,
  applicabile(Az, S),
  trasforma(Az, S, S_Nuovo),
  \+member(S_Nuovo, Visitati),
  NuovaSoglia is Soglia-1,
  dfs_limit(S_Nuovo, SequenzaAzioni, [S_Nuovo|Visitati], NuovaSoglia).
