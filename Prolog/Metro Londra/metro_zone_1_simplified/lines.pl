% percorso(Linea, Dir, ListaFermate)

percorso("Bakerloo",0,["Paddington","Edgware Road","Marylebone","Baker Street","Regent's Park","Oxford Circus","Piccadilly Circus",
  "Charing Cross","Embankment","Waterloo","Lambeth North"]).
percorso("Central",0,["Notting Hill Gate","Queensway","Lancaster Gate","Marble Arch","Bond Street","Oxford Circus","Tottenham Court Road",
  "Holborn","Chancery Lane","St. Paul's","Bank","Liverpool Street"]).
percorso("Circle",0,["Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road",
  "High Street Kensington","Notting Hill Gate","Bayswater","Paddington","Edgware Road","Baker Street","Great Portland Street","Euston Square",
  "King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate","Tower Hill","Monument","Cannon Street",
  "Mansion House","Blackfriars","Temple","Embankment"]).
percorso("Jubilee",0,["Baker Street","Bond Street","Green Park","Westminster","Waterloo","Southwark","London Bridge"]).
percorso("Northern",0,["Euston","King's Cross St. Pancras","Angel","Old Street","Moorgate","Bank","London Bridge","Borough"]).
percorso("Piccadilly",0,["King's Cross St. Pancras","Russell Square","Holborn","Covent Garden","Leicester Square","Piccadilly Circus",
  "Green Park","Hyde Park Corner","Knightsbridge","South Kensington","Gloucester Road","Earl's Court"]).
percorso("Victoria",0,["King's Cross St. Pancras","Euston","Warren Street","Oxford Circus","Green Park","Victoria","Pimlico"]).
percorso("Waterloo & City",0,["Bank","Waterloo"]).

percorso(Linea,1,LR) :- percorso(Linea,0,L), reverse(L,LR).

% tratta(NomeLinea, Dir, StazionePartenza, StazioneArrivo)
tratta(Linea,Dir,SP,SA) :- percorso(Linea,Dir,LF), member_pair(SP,SA,LF).

member_pair(X,Y,[X,Y|_]).
member_pair(X,Y,[_,Z|Rest]) :- member_pair(X,Y,[Z|Rest]).

fermata(Stazione,Linea) :- percorso(Linea,0,P), member(Stazione,P).


iniziale([at("Bayswater"),ground]).

finale([at("Piccadilly Circus"),ground]).
