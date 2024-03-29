heuristic([at(SP),ground], 0) :-
  finale([at(SP),ground]), !.
heuristic([at(SP),in(Linea,_)], Costo) :-
  finale([at(SA),ground]),
  as_heuristic([nodo(SP, [], 0, 0)], CostoRouteNoUpDown, []),
  cambi_in_linea_heuristic([at(SP),in(Linea,0)], [at(SA),ground], CostoMinCambi),
  Costo is CostoRouteNoUpDown + CostoMinCambi.
heuristic([at(SP),ground], Costo) :-
  finale([at(SA),ground]),
  as_heuristic([nodo(SP, [], 0, 0)], CostoRouteNoUpDown, []),
  cambi_in_ground_heuristic([at(SP),ground], [at(SA),ground], CostoMinCambi),
  Costo is CostoRouteNoUpDown + CostoMinCambi.
