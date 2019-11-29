% percorso(Linea, Dir, ListaFermate)

percorso("Bakerloo",0,["Stonebridge Park","Harlesden","Willesden Junction","Kensal Green","Queen's Park","Kilburn Park","Maida Vale",
  "Warwick Avenue","Paddington","Edgware Road","Marylebone","Baker Street","Regent's Park","Oxford Circus","Piccadilly Circus",
  "Charing Cross","Embankment","Waterloo","Lambeth North","Elephant & Castle"]).
percorso("Central",0,["Ealing Broadway","West Acton","North Acton","East Acton","White City","Shepherd's Bush","Holland Park",
  "Notting Hill Gate","Queensway","Lancaster Gate","Marble Arch","Bond Street","Oxford Circus","Tottenham Court Road","Holborn",
  "Chancery Lane","St. Paul's","Bank","Liverpool Street","Bethnal Green","Mile End","Stratford","Leyton"]).
percorso("Circle",0,["Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road",
  "High Street Kensington","Notting Hill Gate","Bayswater","Paddington","Edgware Road","Baker Street","Great Portland Street",
  "Euston Square","King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate","Tower Hill","Monument",
  "Cannon Street","Mansion House","Blackfriars","Temple","Embankment"]).
percorso("District East-West",0,["Upton Park","Plaistow","West Ham","Bromley By Bow","Bow Road","Mile End","Stepney Green",
  "Whitechapel","Aldgate East","Tower Hill","Monument","Cannon Street","Mansion House","Blackfriars","Temple","Embankment","Westminster",
  "St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road","Earl's Court","West Kensington","Barons Court",
  "Hammersmith","Ravenscourt Park","Stamford Brook","Turnham Green","Chiswick Park","Acton Town","Ealing Common","Ealing Broadway"]).
percorso("District North-South",0,["Edgware Road","Paddington","Bayswater","Notting Hill Gate","High Street Kensington","Earl's Court",
  "West Brompton","Fulham Broadway","Parsons Green","Putney Bridge","East Putney","Southfields","Wimbledon Park","Wimbledon"]).
percorso("Hammersmith & City",0,["Hammersmith","Goldhawk Road","Shepherd's Bush Market","Latimer Road","Ladbroke Grove",
  "Westbourne Park","Royal Oak","Paddington","Edgware Road","Baker Street","Great Portland Street","Euston Square",
  "King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate East","Whitechapel",
  "Stepney Green","Mile End","Bow Road","Bromley By Bow","West Ham","Plaistow","Upton Park"]).
percorso("Jubilee",0,["Neasden","Dollis Hill","Willesden Green","Kilburn","West Hampstead","Finchley Road","Swiss Cottage",
  "St. John's Wood","Baker Street","Bond Street","Green Park","Westminster","Waterloo","Southwark","London Bridge","Bermondsey",
  "Canada Water","Canary Wharf","North Greenwich","Canning Town","West Ham","Stratford"]).
percorso("Metropolitan",0,["Finchley Road","Baker Street","Great Portland Street","Euston Square","King's Cross St. Pancras","Farringdon",
  "Barbican","Moorgate","Liverpool Street","Aldgate"]).
percorso("Northern East",0,["East Finchley","Highgate","Archway","Tufnell Park","Kentish Town","Camden Town","Euston",
  "King's Cross St. Pancras","Angel","Old Street","Moorgate","Bank","London Bridge","Borough","Elephant & Castle","Kennington",
  "Oval","Stockwell","Clapham North","Clapham Common","Clapham South","Balham","Tooting Bec","Tooting Broadway","Colliers Wood",
  "South Wimbledon"]).
percorso("Northern West",0,["Hendon Central","Brent Cross","Golders Green","Hampstead","Belsize Park","Chalk Farm","Camden Town",
  "Mornington Crescent","Euston","Warren Street","Goodge Street","Tottenham Court Road","Leicester Square","Charing Cross",
  "Embankment","Waterloo","Kennington","Oval","Stockwell","Clapham North","Clapham Common","Clapham South","Balham","Tooting Bec",
  "Tooting Broadway","Colliers Wood","South Wimbledon"]).
percorso("Piccadilly",0,["Bounds Green","Wood Green","Turnpike Lane","Manor House","Finsbury Park","Arsenal","Holloway Road",
  "Caledonian Road","King's Cross St. Pancras","Russell Square","Holborn","Covent Garden","Leicester Square","Piccadilly Circus",
  "Green Park","Hyde Park Corner","Knightsbridge","South Kensington","Gloucester Road","Earl's Court","Barons Court","Hammersmith",
  "Acton Town","Ealing Common","North Ealing","Park Royal"]).
percorso("Victoria",0,["Walthamstow Central","Blackhorse Road","Tottenham Hale","Seven Sisters","Finsbury Park","Highbury & Islington",
  "King's Cross St. Pancras","Euston","Warren Street","Oxford Circus","Green Park","Victoria","Pimlico","Vauxhall","Stockwell","Brixton"]).
percorso("Waterloo & City",0,["Bank","Waterloo"]).

percorso(Linea,1,LR) :- percorso(Linea,0,L), reverse(L,LR).

% tratta(NomeLinea, Dir, StazionePartenza, StazioneArrivo)
tratta(Linea,Dir,SP,SA) :- percorso(Linea,Dir,LF), member_pair(SP,SA,LF).

member_pair(X,Y,[X,Y|_]).
member_pair(X,Y,[_,Z|Rest]) :- member_pair(X,Y,[Z|Rest]).

fermata(Stazione,Linea) :- percorso(Linea,0,P), member(Stazione,P).


iniziale([at("Ealing Broadway"),ground]).
%iniziale([at("Park Royal"),ground]).
%iniziale([at("Bayswater"), ground]).

%finale([at("Stratford"),ground]).
finale([at("North Greenwich"),ground]).
%finale([at("Notting Hill Gate"),ground]).
%finale([at("Leyton"),ground]).
%finale([at("Cannon Street"), ground]).
