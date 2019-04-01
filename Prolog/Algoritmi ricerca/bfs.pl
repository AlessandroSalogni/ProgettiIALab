breadth_search(Soluzione) :-
  iniziale(S),
  bfs([nodo(S, [])], Soluzione, []).

% bfs_aux(Coda,Visitati,Soluzione)
% Coda = [nodo(S,AzioniFiniS)|...]
bfs([nodo(S, AzioniPerS)|_], AzioniPerS, _) :- finale(S), !. % Azioni è la mia soluzione
bfs([nodo(S, AzioniPerS)|Tail], Soluzione, Visitati) :-
  findall(Azione, applicabile(Azione, S), ListaAzioniApplicabili), % findall restituisce una lista di oggetti che rendono vero il predicato
  expand_children(nodo(S, AzioniPerS), ListaAzioniApplicabili, Visitati, ListaFigli),
  append(Tail, ListaFigli, NuovaCoda),
  bfs(NuovaCoda, Soluzione, [S|Visitati]).

expand_children(_, [], _, []).
expand_children(nodo(S, AzioniPerS), [Azione|AltreAzioni], Visitati, [nodo(S_Nuovo, [Azione|AzioniPerS])|FigliTail]) :-
  trasforma(Azione, S, S_Nuovo),
  \+member(S_Nuovo, Visitati), !,
  expand_children(nodo(S, AzioniPerS), AltreAzioni, Visitati, FigliTail).
expand_children(nodo(S, AzioniPerS), [_|AltreAzioni], Visitati, FigliTail) :- % Viene eseguito quando not member fallisce perchè non è stato eseguito il cut
  expand_children(nodo(S, AzioniPerS), AltreAzioni, Visitati, FigliTail).
