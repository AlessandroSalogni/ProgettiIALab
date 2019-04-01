priority_queue(Coda, [], Coda).
priority_queue(Coda, [Nodo|AltriFigli], NuovaCoda) :-
  insert_node(Coda, Nodo, CodaConNodo),
  priority_queue(CodaConNodo, AltriFigli, NuovaCoda).

insert_node([], Nodo, [Nodo]).
insert_node([nodo(SCoda, AzioniPerSCoda, CostoAzioniPerSCoda, EuristicaDaSCoda)|TailCoda], 
nodo(SNodo, AzioniPerSNodo, CostoAzioniPerSNodo, EuristicaDaSNodo),
[nodo(SCoda, AzioniPerSCoda, CostoAzioniPerSCoda, EuristicaDaSCoda)|NuovaCoda]) :-
  CostoAzioniPerSCoda + EuristicaDaSCoda =< CostoAzioniPerSNodo + EuristicaDaSNodo, !,
  insert_node(TailCoda, nodo(SNodo, AzioniPerSNodo, CostoAzioniPerSNodo, EuristicaDaSNodo), NuovaCoda).
insert_node(Coda, Nodo, [Nodo|Coda]).