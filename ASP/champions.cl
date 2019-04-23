% dati_squadra(nome, nazione, citta, fascia).
dati_squadra("Club Brugge","Belgio","Bruges",4).
dati_squadra("Monaco","Francia","Monaco",3).
dati_squadra("Paris Saint Germain","Francia","Parigi",1).
dati_squadra("Olympic Lione","Francia","Lione",3).
dati_squadra("Borussia Dortmund","Germania","Dortmund",2).
dati_squadra("Schalke 04","Germania","Gelsenkirchen",3).
dati_squadra("Bayern Monaco","Germania","Monaco di Baviera",1).
dati_squadra("Hoffenheim","Germania","Hoffenheim Sinsheim",4).
dati_squadra("AEK","Grecia","Atene",4).
dati_squadra("Tottenham Hotspur","Inghilterra","Londra",2).
dati_squadra("Liverpool","Inghilterra","Liverpool",3).
dati_squadra("Manchester City","Inghilterra","Manchester",1).
dati_squadra("Manchester United","Inghilterra","Manchester",2).
dati_squadra("Inter","Italia","Milano",4).
dati_squadra("Napoli","Italia","Napoli",2).
dati_squadra("Roma","Italia","Roma",2).
dati_squadra("Juventus","Italia","Torino",1).
dati_squadra("PSV Eindhoven","Olanda","Eindhoven",3).
dati_squadra("Ajax","Olanda","Amsterdam",3).
dati_squadra("Porto","Portogallo","Porto",2).
dati_squadra("Benfica","Portogallo","Lisbona",2).
dati_squadra("Viktoria Plzen","Repubblica Ceca","Plzen",4).
dati_squadra("Lokomotiv Mosca","Russia","Mosca",1).
dati_squadra("CSKA Mosca","Russia","Mosca",3).
dati_squadra("Stella Rossa","Serbia","Belgrado",4).
dati_squadra("Atletico Madrid","Spagna","Madrid",1).
dati_squadra("Barcellona","Spagna","Barcellona",1).
dati_squadra("Real Madrid","Spagna","Madrid",1).
dati_squadra("Valencia","Spagna","Valencia",3).
dati_squadra("Young Boys","Svizzera","Berna",4).
dati_squadra("Galatasaray","Turchia","Istanbul",4).
dati_squadra("Shakhtar Donetsk","Ucraina","Donetsk",2).

girone("A","Rosso").
girone("B","Rosso").
girone("C","Rosso").
girone("D","Rosso").
girone("E","Blu").
girone("F","Blu").
girone("G","Blu").
girone("H","Blu").

1 { assegna_girone(Squadra,Naz,G) : girone(G,_) } 1 :- dati_squadra(Squadra,Naz,_,_).
4 { assegna_girone(Squadra,Naz,G) : dati_squadra(Squadra,Naz,_,_) } 4 :- girone(G,_).

stessa_nazione(SquadraX,SquadraY) :-
  dati_squadra(SquadraX,Naz,_,_),
  dati_squadra(SquadraY,Naz,_,_),
  SquadraX != SquadraY.

stessa_fascia(SquadraX,SquadraY) :-
  dati_squadra(SquadraX,_,_,Fascia),
  dati_squadra(SquadraY,_,_,Fascia),
  SquadraX != SquadraY.

squadra_russa(Squadra) :-
  dati_squadra(Squadra,Naz,_,_),
  Naz == "Russia".

squadra_ucraina(Squadra) :-
  dati_squadra(Squadra,Naz,_,_),
  Naz == "Ucraina".

:- assegna_girone(SquadraX,_,G), assegna_girone(SquadraY,_,G), stessa_nazione(SquadraX,SquadraY).
:- assegna_girone(SquadraX,_,G), assegna_girone(SquadraY,_,G), stessa_fascia(SquadraX,SquadraY).
:- assegna_girone(SquadraX,_,G), assegna_girone(SquadraY,_,G), squadra_russa(SquadraX), squadra_ucraina(SquadraY).

nazione(Naz) :- dati_squadra(_,Naz,_,_).
n_squadre_per_nazione(Naz, N) :- N = #count{ Squadra : dati_squadra(Squadra,Naz,_,_) }, nazione(Naz).
n_squadre_per_nazione_in_girone_rosso(Naz, N) :- N = #count{ Squadra : assegna_girone(Squadra,Naz,G),girone(G,"Rosso") }, nazione(Naz).
n_squadre_per_nazione_in_girone_blu(Naz, N) :- N = #count{ Squadra : assegna_girone(Squadra,Naz,G),girone(G,"Blu") }, nazione(Naz).

:- n_squadre_per_nazione_in_girone_rosso(Naz,NSquadreInRosso), n_squadre_per_nazione(Naz,NSquadre), NSquadreInRosso*10 > NSquadre*10/2+5.
:- n_squadre_per_nazione_in_girone_blu(Naz,NSquadreInBlu), n_squadre_per_nazione(Naz,NSquadre), NSquadreInBlu*10 > NSquadre*10/2+5.


%Partite

3 { scontri(SquadraX,SquadraY,G) :  assegna_girone(SquadraY,_,G), SquadraX != SquadraY } 3 :- assegna_girone(SquadraX,_,G).

giornata(1..6).
1 { partita(SquadraX,SquadraY,Giorn,G) : giornata(Giorn) } 1 :- scontri(SquadraX,SquadraY,G).
16 { partita(SquadraX,SquadraY,Giorn,G) : scontri(SquadraX,SquadraY,G) } 16 :- giornata(Giorn).

:- partita(SquadraX,SquadraY,Giorn,_), partita(SquadraX,SquadraZ,Giorn,_), SquadraY != SquadraZ. % No 2 partite di x in casa contro squadre diverse nella stessa giornata
:- partita(SquadraY,SquadraX,Giorn,_), partita(SquadraZ,SquadraX,Giorn,_), SquadraY != SquadraZ. % No 2 partite di x in trasferta contro squadre diverse nella stessa giornata
:- partita(SquadraX,SquadraY,Giorn,_), partita(SquadraZ,SquadraX,Giorn,_). % No 2 partite di x in casa/trasferta nella stessa giornata contro la stessa squadra o una squadra diversa

stessa_citta(SquadraX,SquadraY) :-
  dati_squadra(SquadraX,_,Citta,_),
  dati_squadra(SquadraY,_,Citta,_),
  SquadraX != SquadraY.

:- partita(SquadraX,_,Giorn,_), partita(SquadraY,_,Giorn,_), stessa_citta(SquadraX,SquadraY).

:- partita(Squadra,_,Giorn1,_), partita(Squadra,_,Giorn2,_), partita(Squadra,_,Giorn3,_), Giorn2 == Giorn1 + 1, Giorn3 == Giorn2 + 1. % No più di 2 partite in casa consecutive
:- partita(_,Squadra,Giorn1,_), partita(_,Squadra,Giorn2,_), partita(_,Squadra,Giorn3,_), Giorn2 == Giorn1 + 1, Giorn3 == Giorn2 + 1. % No più di 2 partite in trasferta consecutive

:- partita(SquadraX,SquadraY,Giorn1,_), partita(SquadraY,SquadraX,Giorn2,_), Giorn1 > 3, Giorn2 > 3. % No andata e ritorno entrambe nelle ultime 3 gare
%:- partita(SquadraX,SquadraY,Giorn1,_), partita(SquadraY,SquadraX,Giorn2,_), Giorn1 <= 3, Giorn2 <= 3. % No andata e ritorno entrambe nelle prime 3 gare

#show  partita/4.
