iterative_deepening(Soluzione) :-
  iniziale(S),
  id_limit(S, Soluzione, [S], 0).

id_limit(S, Soluzione, Visitati, Soglia) :- 
  dfs_limit(S, Soluzione, Visitati, Soglia), !.
id_limit(S, Soluzione, Visitati, Soglia) :-
  NuovaSoglia is Soglia + 1,
  id_limit(S, Soluzione, Visitati, NuovaSoglia).
