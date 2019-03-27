breadth_search(Soluzione) :-
  iniziale(S),
  bfs([nodo(S, [])], Soluzione, []).

% bfs_aux(Coda,Visitati,Soluzione)
% Coda = [nodo(S,AzioniFiniS)|...]
bfs([nodo(S, AzioniPerS)|_], AzioniPerS, _) :- finale(S), !. % Azioni è la mia soluzione
bfs([nodo(S, AzioniPerS)|Tail], Soluzione, Visitati) :-
  findall(Azione, applicabile(Azione, S), ListaAzioniApplicabili), % findall restituisce una lista di oggetti che rendono vero il predicato
  generaFigli(nodo(S, AzioniPerS), ListaAzioniApplicabili, Visitati, ListaFigli),
  append(Tail, ListaFigli, NuovaCoda),
  bfs(NuovaCoda, Soluzione, [S|Visitati]).

generaFigli(_, [], _, []).
generaFigli(nodo(S, AzioniPerS), [Azione|AltreAzioni], Visitati, [nodo(S_Nuovo, [Azione|AzioniPerS])|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  \+member(S_Nuovo, Visitati), !,
  generaFigli(nodo(S, AzioniPerS), AltreAzioni, Visitati, FigliTail).
generaFigli(nodo(S, AzioniPerS), [_|AltreAzioni], Visitati, FigliTail) :- % Viene eseguito quando not member fallisce perchè non è stato eseguito il cut
  generaFigli(nodo(S, AzioniPerS), AltreAzioni, Visitati, FigliTail).
