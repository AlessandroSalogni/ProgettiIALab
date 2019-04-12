% Coda di priorità
priority_queue(Coda, [], Coda).
priority_queue(Coda, [Nodo|AltriFigli], NuovaCoda) :-
  insert_node(Coda, Nodo, CodaConNodo),
  priority_queue(CodaConNodo, AltriFigli, NuovaCoda).

insert_node([], Nodo, [Nodo]).
insert_node([nodo(SCoda, AzPerSCoda, CostoAzPerSCoda, EuristicaDaSCoda)|TailCoda], nodo(SNodo, AzPerSNodo, CostoAzPerSNodo, EuristicaDaSNodo),
[nodo(SCoda, AzPerSCoda, CostoAzPerSCoda, EuristicaDaSCoda)|NuovaCoda]) :-
  CostoAzPerSCoda + EuristicaDaSCoda =< CostoAzPerSNodo + EuristicaDaSNodo, !,
  insert_node(TailCoda, nodo(SNodo, AzPerSNodo, CostoAzPerSNodo, EuristicaDaSNodo), NuovaCoda).
insert_node(Coda, Nodo, [Nodo|Coda]).

% Predicato per decidere se rivisitare i nodi in a star
revisit_node(_, [], []).
revisit_node(nodo(S, CostoAzPerS), [nodo(S, CostoAzPerSVis)|AltriVis], AltriVis) :- !, CostoAzPerS < CostoAzPerSVis.
revisit_node(nodo(S, CostoAzPerS), [nodo(SVis, CostoAzPerSVis)|AltriVis], [nodo(SVis, CostoAzPerSVis)|NuoviVis]) :-
  revisit_node(nodo(S, CostoAzPerS), AltriVis, NuoviVis).

% Predicati che calcola il costo per salire e scendere da una Metro
costo_sali_scendi(CostoSaliScendi) :-
  costo_scendi(CostoScendi),
  costo_sali(CostoSali),
  CostoSaliScendi is CostoSali + CostoScendi.

costo_scendi(CostoScendi) :- costo(scendi(_), CostoScendi).
costo_sali(CostoSali) :- costo(sali(_,_), CostoSali).
