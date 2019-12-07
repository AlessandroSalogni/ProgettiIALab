% stato: [at(Stazione), Location]
% Location può essere in(NomeLinea, Dir) o
%  'ground' se l'agente non è su nessun treno
% Dir può esere 0 o 1

% Azioni:
%  sali(Linea, Dir)
%  scendi(Stazione)
%  vai(Linea, Dir, StazionePartenza, StazioneArrivo)

applicabile(sali(Linea,Dir),[at(Stazione),ground]) :- fermata(Stazione,Linea), member(Dir,[0,1]).
applicabile(scendi(Stazione),[at(Stazione),in(_,_)]) :- \+chiusa(Stazione).
applicabile(vai(Linea,Dir,SP,SA),[at(SP),in(Linea,Dir)]) :- tratta(Linea,Dir,SP,SA).

trasforma(sali(Linea,Dir),[at(Stazione),ground],[at(Stazione),in(Linea,Dir)]).
trasforma(scendi(Stazione),[at(Stazione),in(_,_)],[at(Stazione),ground]).
trasforma(vai(Linea,Dir,SP,SA),[at(SP),in(Linea,Dir)],[at(SA),in(Linea,Dir)]).

costo(sali(_,_), 4).
costo(scendi(_), 1).
costo(vai(_,_,SP,SA), Costo) :- coords_distance(SP,SA,Costo).
  
