heuristic([at(SP),_], Costo) :-
  as_heuristic([nodo(SP, [], 0, 0)], Costo, []).
