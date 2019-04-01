a_star(Soluzione) :-
  statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
  iniziale(S),
  as([nodo(S, [], 0, 0)], Soluzione, 0), %euristica a 0?
  statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
  write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

as([nodo(S, AzPerS, CostoAzPerS, _)|_], AzPerS, Espansi) :- finale(S), write(CostoAzPerS), nl, !, write(Espansi), nl.
as([nodo(S, AzPerS, CostoAzPerS, EuristicaDaS)|Tail], Soluzione, Espansi) :-
  findall(Azione, applicabile(Azione, S), ListaAzApplicabili),
  expand_children(nodo(S, AzPerS, CostoAzPerS, EuristicaDaS), ListaAzApplicabili, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  NuovoEspansi is Espansi + 1,
  as(NuovaCoda, Soluzione, NuovoEspansi).

expand_children(_, [], []).
expand_children(nodo(S, AzPerS, CostoAzPerS, EuristicaDaS), [Azione|AltreAz],
[nodo(S_Nuovo, [Azione|AzPerS], CostoAzPerSNuovo, EuristicaDaSNuovo)|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  costo(Azione, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  heuristic(S_Nuovo, EuristicaDaSNuovo),
  expand_children(nodo(S, AzPerS, CostoAzPerS, EuristicaDaS), AltreAz, FigliTail).
