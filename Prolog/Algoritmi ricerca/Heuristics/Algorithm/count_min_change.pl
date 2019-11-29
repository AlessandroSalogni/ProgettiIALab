cambi_in_linea_heuristic([at(SP),in(Linea,_)], [at(SA),_], Costo) :-
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


cambi("Bakerloo", "Central", 1).
cambi("Bakerloo", "Circle", 1).
cambi("Bakerloo", "District East-West", 1).
cambi("Bakerloo", "District North-South", 1).
cambi("Bakerloo", "Hammersmith & City", 1).
cambi("Bakerloo", "Jubilee", 1).
cambi("Bakerloo", "Metropolitan", 1).
cambi("Bakerloo", "Northern East", 1).
cambi("Bakerloo", "Northern West", 1).
cambi("Bakerloo", "Piccadilly", 1).
cambi("Bakerloo", "Victoria", 1).
cambi("Bakerloo", "Waterloo & City", 1).
cambi("Central", "Circle", 1).
cambi("Central", "District East-West", 1).
cambi("Central", "District North-South", 1).
cambi("Central", "Hammersmith & City", 1).
cambi("Central", "Jubilee", 1).
cambi("Central", "Metropolitan", 1).
cambi("Central", "Northern East", 1).
cambi("Central", "Northern West", 1).
cambi("Central", "Piccadilly", 1).
cambi("Central", "Victoria", 1).
cambi("Central", "Waterloo & City", 1).
cambi("Circle", "District East-West", 1).
cambi("Circle", "District North-South", 1).
cambi("Circle", "Hammersmith & City", 1).
cambi("Circle", "Jubilee", 1).
cambi("Circle", "Metropolitan", 1).
cambi("Circle", "Northern East", 1).
cambi("Circle", "Northern West", 1).
cambi("Circle", "Piccadilly", 1).
cambi("Circle", "Victoria", 1).
cambi("Circle", "Waterloo & City", 2).
cambi("District East-West", "District North-South", 1).
cambi("District East-West", "Hammersmith & City", 1).
cambi("District East-West", "Jubilee", 1).
cambi("District East-West", "Metropolitan", 2).
cambi("District East-West", "Northern East", 2).
cambi("District East-West", "Northern West", 1).
cambi("District East-West", "Piccadilly", 1).
cambi("District East-West", "Victoria", 1).
cambi("District East-West", "Waterloo & City", 2).
cambi("District North-South", "Hammersmith & City", 1).
cambi("District North-South", "Jubilee", 2).
cambi("District North-South", "Metropolitan", 2).
cambi("District North-South", "Northern East", 2).
cambi("District North-South", "Northern West", 2).
cambi("District North-South", "Piccadilly", 1).
cambi("District North-South", "Victoria", 2).
cambi("District North-South", "Waterloo & City", 2).
cambi("Hammersmith & City", "Jubilee", 1).
cambi("Hammersmith & City", "Metropolitan", 1).
cambi("Hammersmith & City", "Northern East", 1).
cambi("Hammersmith & City", "Northern West", 2).
cambi("Hammersmith & City", "Piccadilly", 1).
cambi("Hammersmith & City", "Victoria", 1).
cambi("Hammersmith & City", "Waterloo & City", 2).
cambi("Jubilee", "Metropolitan", 1).
cambi("Jubilee", "Northern East", 1).
cambi("Jubilee", "Northern West", 1).
cambi("Jubilee", "Piccadilly", 1).
cambi("Jubilee", "Victoria", 1).
cambi("Jubilee", "Waterloo & City", 1).
cambi("Metropolitan", "Northern East", 1).
cambi("Metropolitan", "Northern West", 2).
cambi("Metropolitan", "Piccadilly", 1).
cambi("Metropolitan", "Victoria", 1).
cambi("Metropolitan", "Waterloo & City", 2).
cambi("Northern East", "Northern West", 1).
cambi("Northern East", "Piccadilly", 1).
cambi("Northern East", "Victoria", 1).
cambi("Northern East", "Waterloo & City", 1).
cambi("Northern West", "Piccadilly", 1).
cambi("Northern West", "Victoria", 1).
cambi("Northern West", "Waterloo & City", 1).
cambi("Piccadilly", "Victoria", 1).
cambi("Piccadilly", "Waterloo & City", 2).
cambi("Victoria", "Waterloo & City", 2).

cambi(Linea1, Linea2, Cambi) :- cambi(Linea2, Linea1, Cambi).
