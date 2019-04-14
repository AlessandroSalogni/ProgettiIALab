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

1 { assegna_girone(Squadra,G) : girone(G,_) } 1 :- dati_squadra(Squadra,_,_,_).
4 { assegna_girone(Squadra,G) : dati_squadra(Squadra,_,_,_) } 4 :- girone(G,_).

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

:- assegna_girone(SquadraX,G), assegna_girone(SquadraY,G), stessa_nazione(SquadraX,SquadraY).
:- assegna_girone(SquadraX,G), assegna_girone(SquadraY,G), stessa_fascia(SquadraX,SquadraY).
:- assegna_girone(SquadraX,G), assegna_girone(SquadraY,G), squadra_russa(SquadraX), squadra_ucraina(SquadraY).

#show assegna_girone/2.
