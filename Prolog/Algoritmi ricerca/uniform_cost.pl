uniform_cost(Soluzione) :-
  statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
  iniziale(S),
  uc([nodo(S, [], 0, 0)], Soluzione, [], 0),
  statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
  write('Execution took '), write(ExecutionTime), write(' ms.'), nl.

uc([nodo(S, AzPerS, CostoAzPerS, _)|_], AzPerS, _, Espansi) :- finale(S), /*!,*/ write(CostoAzPerS), nl, write(Espansi), nl.
uc([nodo(S, AzPerS, CostoAzPerS, _)|Tail], Soluzione, Visitati, Espansi) :-
  findall(Azione, applicabile(Azione, S), ListaAzApplicabili),
  expand_children_uc(nodo(S, AzPerS, CostoAzPerS, 0), ListaAzApplicabili, Visitati, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  NodiEspansi is Espansi + 1,
  write(nodo(S, CostoAzPerS)), nl,
  uc(NuovaCoda, Soluzione, [S|Visitati], NodiEspansi).

expand_children_uc(_, [], _, []).
expand_children_uc(nodo(S, AzPerS, CostoAzPerS, _), [Azione|AltreAz], Visitati, [nodo(S_Nuovo, [Azione|AzPerS], CostoAzPerSNuovo, 0)|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  \+member(S_Nuovo, Visitati), !,
  costo(Azione, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  expand_children_uc(nodo(S, AzPerS, CostoAzPerS, 0), AltreAz, Visitati, FigliTail).
expand_children_uc(Nodo, [_|AltreAz], Visitati, FigliTail) :- % Viene eseguito quando not member fallisce perchè non è stato eseguito il cut
  expand_children_uc(Nodo, AltreAz, Visitati, FigliTail).
