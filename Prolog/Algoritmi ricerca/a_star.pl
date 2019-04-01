a_star(Soluzione) :-
    iniziale(S),
    as([nodo(S, [], 0, 0)], Soluzione, 0). %euristica a 0?

as([nodo(S, AzioniPerS, _, _)|_], AzioniPerS, Espansi) :- finale(S), !, write(Espansi), nl.
as([nodo(S, AzioniPerS, CostoAzioniPerS, EuristicaDaS)|Tail], Soluzione, Espansi) :-
  findall(Azione, applicabile(Azione, S), ListaAzioniApplicabili),
  expand_children(nodo(S, AzioniPerS, CostoAzioniPerS, EuristicaDaS), ListaAzioniApplicabili, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  NuovoEspansi is Espansi + 1,
  as(NuovaCoda, Soluzione, NuovoEspansi).

expand_children(_, [], []).
expand_children(nodo(S, AzioniPerS, CostoAzioniPerS, EuristicaDaS), [Azione|AltreAzioni],
[nodo(S_Nuovo, [Azione|AzioniPerS], CostoAzioniPerSNuovo, EuristicaDaSNuovo)|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  costo(Azione, Costo),
  CostoAzioniPerSNuovo is CostoAzioniPerS + Costo,
  heuristic(S_Nuovo, EuristicaDaSNuovo),
  expand_children(nodo(S, AzioniPerS, CostoAzioniPerS, EuristicaDaS), AltreAzioni, FigliTail).
