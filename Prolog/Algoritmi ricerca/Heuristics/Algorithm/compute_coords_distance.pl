coords_distance(SP, SA, Costo) :-
  stazione(SP, SPx, SPy),
  stazione(SA, SAx, SAy),
  P is 0.017453292519943295,
  A is (0.5 - cos((SAy - SPy) * P) / 2 + cos(SPy * P) * cos(SAy * P) * (1 - cos((SAx - SPx) * P)) / 2),
  Dis is (12742 * asin(sqrt(A))),
  Costo is (Dis * 1000 / 10) / 60. % (secondi) /60 -> minuti
