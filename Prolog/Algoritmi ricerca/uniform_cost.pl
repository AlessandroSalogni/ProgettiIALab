uniform_cost(Soluzione) :-
  iniziale(S),
  uc([nodo(S, [], 0)], Soluzione).

uc([nodo(S, AzioniPerS, CostoAzioniPerS)|_], AzioniPerS) :- finale(S), !, write(CostoAzioniPerS), nl.
uc([nodo(S, AzioniPerS, CostoAzioniPerS)|Tail], Soluzione) :-
  findall(Azione, applicabile(Azione, S), ListaAzioniApplicabili),
  generaFigli(nodo(S, AzioniPerS, CostoAzioniPerS), ListaAzioniApplicabili, ListaFigli),
  coda_priorita(Tail, ListaFigli, NuovaCoda),
  uc(NuovaCoda, Soluzione).

generaFigli(_, [], []).
generaFigli(nodo(S, AzioniPerS, CostoAzioniPerS), [Azione|AltreAzioni], [nodo(S_Nuovo, [Azione|AzioniPerS], CostoAzioniPerSNuovo)|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  costo(Azione, Costo),
  CostoAzioniPerSNuovo is CostoAzioniPerS + Costo,
  generaFigli(nodo(S, AzioniPerS, CostoAzioniPerS), AltreAzioni, FigliTail).

coda_priorita(Coda, [], Coda).
coda_priorita(Coda, [Nodo|AltriFigli], NuovaCoda) :-
  inserisci_nodo(Coda, Nodo, CodaConNodo),
  coda_priorita(CodaConNodo, AltriFigli, NuovaCoda).

inserisci_nodo([], Nodo, [Nodo]).
inserisci_nodo([nodo(SCoda, AzioniPerSCoda, CostoAzioniPerSCoda)|TailCoda], nodo(SNodo, AzioniPerSNodo, CostoAzioniPerSNodo),
[nodo(SCoda, AzioniPerSCoda, CostoAzioniPerSCoda)|NuovaCoda]) :-
  CostoAzioniPerSCoda =< CostoAzioniPerSNodo, !,
  inserisci_nodo(TailCoda, nodo(SNodo, AzioniPerSNodo, CostoAzioniPerSNodo), NuovaCoda).
inserisci_nodo(Coda, Nodo, [Nodo|Coda]).
