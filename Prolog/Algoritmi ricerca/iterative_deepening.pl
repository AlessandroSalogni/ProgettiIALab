iterative_deepening(Soluzione) :-
  statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
  iniziale(S),
  id_limit(S, Soluzione, [S], 0),
  statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
  write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

id_limit(S, Soluzione, Visitati, Soglia) :- 
  dfs_limit(S, Soluzione, Visitati, Soglia), !.
id_limit(S, Soluzione, Visitati, Soglia) :-
  NuovaSoglia is Soglia + 1,
  id_limit(S, Soluzione, Visitati, NuovaSoglia).
