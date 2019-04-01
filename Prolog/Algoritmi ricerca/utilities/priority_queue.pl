coda_priorita(Coda, [], Coda).
coda_priorita(Coda, [Nodo|AltriFigli], NuovaCoda) :-
  inserisci_nodo(Coda, Nodo, CodaConNodo),
  coda_priorita(CodaConNodo, AltriFigli, NuovaCoda).

inserisci_nodo([], Nodo, [Nodo]).
inserisci_nodo([nodo(SCoda, AzioniPerSCoda, CostoAzioniPerSCoda, EuristicaDaSCoda)|TailCoda], 
nodo(SNodo, AzioniPerSNodo, CostoAzioniPerSNodo, EuristicaDaSNodo),
[nodo(SCoda, AzioniPerSCoda, CostoAzioniPerSCoda, EuristicaDaSCoda)|NuovaCoda]) :-
  CostoAzioniPerSCoda + EuristicaDaSCoda =< CostoAzioniPerSNodo + EuristicaDaSNodo, !,
  inserisci_nodo(TailCoda, nodo(SNodo, AzioniPerSNodo, CostoAzioniPerSNodo, EuristicaDaSNodo), NuovaCoda).
inserisci_nodo(Coda, Nodo, [Nodo|Coda]).