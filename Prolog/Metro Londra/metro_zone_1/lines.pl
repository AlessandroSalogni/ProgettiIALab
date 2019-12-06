% percorso(Linea, Dir, ListaFermate)

percorso("Bakerloo",0,["Paddington","Edgware Road","Marylebone","Baker Street","Regent's Park","Oxford Circus","Piccadilly Circus",
  "Charing Cross","Embankment","Waterloo","Lambeth North"]).
percorso("Central",0,["Notting Hill Gate","Queensway","Lancaster Gate","Marble Arch","Bond Street","Oxford Circus","Tottenham Court Road",
  "Holborn","Chancery Lane","St. Paul's","Bank","Liverpool Street"]).
percorso("Circle",0,["Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road",
  "High Street Kensington","Notting Hill Gate","Bayswater","Paddington","Edgware Road","Baker Street","Great Portland Street",
  "Euston Square","King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate","Tower Hill",
  "Monument","Cannon Street","Mansion House","Blackfriars","Temple","Embankment"]).
percorso("District East-West",0,["Aldgate East","Tower Hill","Monument","Cannon Street","Mansion House","Blackfriars","Temple",
  "Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road","Earl's Court"]).
percorso("District North-South",0,["Edgware Road","Paddington","Bayswater","Notting Hill Gate","High Street Kensington","Earl's Court"]).
percorso("Hammersmith & City",0,["Paddington","Edgware Road","Baker Street","Great Portland Street","Euston Square",
  "King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate East"]).
percorso("Jubilee",0,["Baker Street","Bond Street","Green Park","Westminster","Waterloo","Southwark","London Bridge"]).
percorso("Metropolitan",0,["Baker Street","Great Portland Street","Euston Square","King's Cross St. Pancras","Farringdon",
  "Barbican","Moorgate","Liverpool Street","Aldgate"]).
percorso("Northern East",0,["Euston","King's Cross St. Pancras","Angel","Old Street","Moorgate","Bank","London Bridge","Borough"]).
percorso("Northern West",0,["Euston","Warren Street","Goodge Street","Tottenham Court Road","Leicester Square","Charing Cross",
  "Embankment","Waterloo"]).
percorso("Piccadilly",0,["King's Cross St. Pancras","Russell Square","Holborn","Covent Garden","Leicester Square","Piccadilly Circus","Green Park","Hyde Park Corner",
  "Knightsbridge","South Kensington","Gloucester Road","Earl's Court"]).
percorso("Victoria",0,["King's Cross St. Pancras","Euston","Warren Street","Oxford Circus","Green Park","Victoria","Pimlico"]).
percorso("Waterloo & City",0,["Bank","Waterloo"]).

percorso(Linea,1,LR) :- percorso(Linea,0,L), reverse(L,LR).

% tratta(NomeLinea, Dir, StazionePartenza, StazioneArrivo)
tratta(Linea,Dir,SP,SA) :- percorso(Linea,Dir,LF), member_pair(SP,SA,LF).

member_pair(X,Y,[X,Y|_]).
member_pair(X,Y,[_,Z|Rest]) :- member_pair(X,Y,[Z|Rest]).

fermata(Stazione,Linea) :- percorso(Linea,0,P), member(Stazione,P).


iniziale([at("Bayswater"),ground]).

finale([at("Southwark"),ground]).
% finale([at("Euston Square"), ground]).