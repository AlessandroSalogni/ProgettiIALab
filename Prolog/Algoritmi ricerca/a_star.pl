a_star(Soluzione) :-
  statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
  iniziale(S),
  as([nodo(S, [], 0, 0)], Soluzione, [], 0), %Eur a 0?
  statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
  write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

as([nodo(S, AzPerS, CostoAzPerS, _)|_], AzPerS, _, Espansi) :- finale(S), write(CostoAzPerS), nl, !, write(Espansi), nl.
as([nodo(S, AzPerS, CostoAzPerS, EurDaS)|Tail], Soluzione, Vis, Espansi) :-
  findall(Az, applicabile(Az, S), ListaAzApplicabili),
  expand_children_as(nodo(S, AzPerS, CostoAzPerS, EurDaS), ListaAzApplicabili, Vis, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  NuovoEspansi is Espansi + 1,
  as(NuovaCoda, Soluzione, [nodo(S, CostoAzPerS)|Vis], NuovoEspansi).

expand_children_as(_, [], _, []).
expand_children_as(nodo(S, AzPerS, CostoAzPerS, EurDaS), [Az|AltreAz], Vis, [nodo(S_Nuovo, [Az|AzPerS], CostoAzPerSNuovo, EurDaSNuovo)|FigliTail]) :-
  trasforma(Az, S, S_Nuovo),
  costo(Az, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  revisit_node(nodo(S_Nuovo, CostoAzPerSNuovo), Vis, NuoviVis), !,
  heuristic(S_Nuovo, EurDaSNuovo),
  expand_children_as(nodo(S, AzPerS, CostoAzPerS, EurDaS), AltreAz, NuoviVis, FigliTail).
expand_children_as(Nodo, [_|AltreAz], Vis, FigliTail) :- expand_children_as(Nodo, AltreAz, Vis, FigliTail).

revisit_node(_, [], []).
revisit_node(nodo(S, CostoAzPerS), [nodo(S, CostoAzPerSVis)|AltriVis], AltriVis) :- !, CostoAzPerS < CostoAzPerSVis.
revisit_node(nodo(S, CostoAzPerS), [nodo(SVis, CostoAzPerSVis)|AltriVis], [nodo(SVis, CostoAzPerSVis)|NuoviVis]) :-
  revisit_node(nodo(S, CostoAzPerS), AltriVis, NuoviVis).
