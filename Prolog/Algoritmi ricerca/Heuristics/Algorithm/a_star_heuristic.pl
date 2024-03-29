as_heuristic([nodo(SA, _, CostoAzPerS, _)|_], CostoAzPerS, _) :-  finale([at(SA),_]), !.
as_heuristic([nodo(S, AzPerS, CostoAzPerS, EurDaS)|Tail], Soluzione, Vis) :-
  findall(Az, applicabile_heuristic(Az, S), ListaAzApplicabili),
  expand_children_as_heuristic(nodo(S, AzPerS, CostoAzPerS, EurDaS), ListaAzApplicabili, Vis, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  as_heuristic(NuovaCoda, Soluzione, [nodo(S, CostoAzPerS)|Vis]).

expand_children_as_heuristic(_, [], _, []).
expand_children_as_heuristic(nodo(S, AzPerS, CostoAzPerS, EurDaS), [Az|AltreAz], Vis, [nodo(S_Nuovo, [Az|AzPerS], CostoAzPerSNuovo, EurDaSNuovo)|FigliTail]) :-
  trasforma_heuristic(Az, S, S_Nuovo),
  costo_heuristic(Az, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  revisit_node(nodo(S_Nuovo, CostoAzPerSNuovo), Vis, NuoviVis), !,
  coords_distance_heuristic(S_Nuovo, EurDaSNuovo),
  expand_children_as_heuristic(nodo(S, AzPerS, CostoAzPerS, EurDaS), AltreAz, NuoviVis, FigliTail).
expand_children_as_heuristic(Nodo, [_|AltreAz], Vis, FigliTail) :- expand_children_as_heuristic(Nodo, AltreAz, Vis, FigliTail).

coords_distance_heuristic(SP, Costo) :-
  finale([at(SA),_]),
  coords_distance(SP,SA,Costo).

applicabile_heuristic(vai(SP, SA, Dir), SP) :- coppie_stazioni(SP, SA, Dir).
trasforma_heuristic(vai(SP, SA, _), SP, SA).
costo_heuristic(vai(SP, SA, _), Costo) :- coords_distance(SP,SA,Costo).