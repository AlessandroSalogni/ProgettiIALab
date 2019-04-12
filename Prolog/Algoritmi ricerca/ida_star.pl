ida_star(Soluzione) :-
  iniziale(S),
  statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
  heuristic(S, EurDaS),
  idas_limit(nodo(S, 0, EurDaS), Soluzione, [S], EurDaS),
  statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
  write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

idas_limit(S, Soluzione, Visitati, Soglia) :-
  dfs_idas_limit(S, Soluzione, Visitati, Soglia), !.
idas_limit(S, Soluzione, Visitati, _) :-
  nuova_soglia(NuovaSoglia),
  retract(nuova_soglia(NuovaSoglia)),
  asserta(nuova_soglia(10000)),
  idas_limit(S, Soluzione, Visitati, NuovaSoglia).

dfs_idas_limit(nodo(S, CostoAzPerS, _), [], _, _) :- finale(S),  write(CostoAzPerS), nl, !.
dfs_idas_limit(nodo(S, CostoAzPerS, EurDaS), [Az|SequenzaAzioni], Visitati, Soglia) :-
  nuova_soglia(NuovaSoglia),
  Soglia >= CostoAzPerS + EurDaS, !,
  applicabile(Az, S),
  trasforma(Az, S, S_Nuovo),
  \+member(S_Nuovo, Visitati),
  costo(Az, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  heuristic(S_Nuovo, EurDaSNuovo),
  dfs_idas_limit(nodo(S_Nuovo, CostoAzPerSNuovo, EurDaSNuovo), SequenzaAzioni, [S_Nuovo|Visitati], Soglia).
dfs_idas_limit(nodo(_, CostoAzPerS, EurDaS), _, _, _) :-
  nuova_soglia(NuovaSoglia),
  NuovaSogliaPossibile is CostoAzPerS + EurDaS,
  NuovaSogliaPossibile < NuovaSoglia,
  retract(nuova_soglia(NuovaSoglia)),
  asserta(nuova_soglia(NuovaSogliaPossibile)),
  fail.

:- dynamic(nuova_soglia/1).
nuova_soglia(10000).
