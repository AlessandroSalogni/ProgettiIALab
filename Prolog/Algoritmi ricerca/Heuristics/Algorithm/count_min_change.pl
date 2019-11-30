cambi_in_linea_heuristic([at(_),in(Linea,_)], [at(SA),_], Costo) :-
  findall(sali(LineaArrivo, 0), applicabile(sali(LineaArrivo, 0), [at(SA),ground]), ListaLineeArrivo),
  calcola_min_cambi_in_linea(Linea, ListaLineeArrivo, MinCambi),
  costo_sali_scendi(CostoSaliScendi),
  costo_scendi(CostoScendi),
  Costo is MinCambi * CostoSaliScendi + CostoScendi.
cambi_in_ground_heuristic([at(SP),ground], [at(SA),_], Costo) :-
  findall(sali(LineaArrivo, 0), applicabile(sali(LineaArrivo, 0), [at(SA),ground]), ListaLineeArrivo),
  findall(sali(LineaPartenza, 0), applicabile(sali(LineaPartenza, 0), [at(SP),ground]), ListaLineePartenza),
  calcola_min_cambi_in_ground(ListaLineePartenza, ListaLineeArrivo, MinCambi),
  costo_sali_scendi(CostoSaliScendi),
  Costo is MinCambi * CostoSaliScendi + CostoSaliScendi.

calcola_min_cambi_in_linea(Linea, [sali(Linea,_)], 0) :- !.
calcola_min_cambi_in_linea(Linea, [sali(LineaFinale,_)], CambiCorrenti) :-
  cambi(Linea, LineaFinale, CambiCorrenti), !.
calcola_min_cambi_in_linea(Linea, [sali(Linea,_)|_], 0) :- !.
calcola_min_cambi_in_linea(Linea, [sali(LineaFinale,_)|AltreAz], MinCambi) :-
  calcola_min_cambi_in_linea(Linea, AltreAz, Cambi),
  cambi(Linea, LineaFinale, CambiCorrenti),
  MinCambi is min(Cambi, CambiCorrenti).

calcola_min_cambi_in_ground([sali(LineaPartenza,_)], AzArrivo, CambiCorrenti) :-
  calcola_min_cambi_in_linea(LineaPartenza, AzArrivo, CambiCorrenti), !.
calcola_min_cambi_in_ground([sali(LineaPartenza,_)|AltreAzPartenza], AzArrivo, MinCambi) :-
  calcola_min_cambi_in_ground(AltreAzPartenza, AzArrivo, Cambi),
  calcola_min_cambi_in_linea(LineaPartenza, AzArrivo, CambiCorrenti),
  MinCambi is min(Cambi, CambiCorrenti).