a_star(Soluzione) :-
  statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
  iniziale(S),
  as([nodo(S, [], 0, 0)], Soluzione, [], 0), %euristica a 0?
  statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
  write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

as([nodo(S, AzPerS, CostoAzPerS, _)|_], AzPerS, _, Espansi) :- finale(S), write(CostoAzPerS), nl, !, write(Espansi), nl.
as([nodo(S, AzPerS, CostoAzPerS, EuristicaDaS)|Tail], Soluzione, Visitati, Espansi) :-
  findall(Azione, applicabile(Azione, S), ListaAzApplicabili),
  expand_children(nodo(S, AzPerS, CostoAzPerS, EuristicaDaS), ListaAzApplicabili, Visitati, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  NuovoEspansi is Espansi + 1,
  as(NuovaCoda, Soluzione, [nodo(S, CostoAzPerS)|Visitati], NuovoEspansi).

expand_children(_, [], _, []).
expand_children(nodo(S, AzPerS, CostoAzPerS, EuristicaDaS), [Azione|AltreAz], Visitati,
[nodo(S_Nuovo, [Azione|AzPerS], CostoAzPerSNuovo, EuristicaDaSNuovo)|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  costo(Azione, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  revisit_node(nodo(S_Nuovo, CostoAzPerSNuovo), Visitati, NuoviVisitati), !,
  heuristic(S_Nuovo, EuristicaDaSNuovo),
  expand_children(nodo(S, AzPerS, CostoAzPerS, EuristicaDaS), AltreAz, NuoviVisitati, FigliTail).
expand_children(Nodo, [Azione|AltreAz], Visitati, FigliTail) :- % Viene eseguito quando not member fallisce perchè non è stato eseguito il cut
  expand_children(Nodo, AltreAz, Visitati, FigliTail).

revisit_node(_, [], []).
revisit_node(nodo(S, CostoAzPerS), [nodo(S, CostoAzPerSVisitato)|AltriVisitati], AltriVisitati) :-
  !, CostoAzPerS < CostoAzPerSVisitato.
revisit_node(nodo(S, CostoAzPerS), [nodo(SVisitato, CostoAzPerSVisitato)|AltriVisitati], [nodo(SVisitato, CostoAzPerSVisitato)|NuoviVisitati]) :-
  revisit_node(nodo(S, CostoAzPerS), AltriVisitati, NuoviVisitati).
