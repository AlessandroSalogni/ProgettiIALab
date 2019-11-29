coords_distance(SP, SA, Costo) :-
  stazione(SP, SPx, SPy),
  stazione(SA, SAx, SAy),
  P is 0.017453292519943295, %Pi/180
  A is (0.5 - cos((SAy - SPy) * P) / 2 + cos(SPy * P) * cos(SAy * P) * (1 - cos((SAx - SPx) * P)) / 2),
  DisKM is (2 * 6371 * asin(sqrt(A))), % R = 6371 = raggio Terra in KM
  DisM is DisKM * 1000,
  Costo is (DisM / 10) / 60. % (Dis in m / 10m/s (36 km/h)) -> (costo in secondi) / 60 -> costo in minuti