% percorso(Linea, Dir, ListaFermate)

percorso("Bakerloo",0,["Paddington","Edgware Road","Marylebone","Baker Street","Regent's Park","Oxford Circus","Piccadilly Circus",
  "Charing Cross","Embankment","Waterloo","Lambeth North"]).
percorso("Central",0,["Notting Hill Gate","Queensway","Lancaster Gate","Marble Arch","Bond Street","Oxford Circus","Tottenham Court Road",
  "Holborn","Chancery Lane","St. Paul's","Bank","Liverpool Street"]).
percorso("Circle",0,["Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road",
  "High Street Kensington","Notting Hill Gate","Bayswater","Paddington","Edgware Road","Baker Street","Great Portland Street","Euston Square",
  "King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate","Tower Hill","Monument","Cannon Street",
  "Mansion House","Blackfriars","Temple","Embankment"]). %Pensare bene alla lista circolare
percorso("Jubilee",0,["Baker Street","Bond Street","Green Park","Westminster","Waterloo","Southwark","London Bridge"]).
percorso("Northern",0,["Euston","King's Cross St. Pancras","Angel","Old Street","Moorgate","Bank","London Bridge","Borough"]).
percorso("Piccadilly",0,["King's Cross St. Pancras","Russell Square","Holborn","Covent Garden","Leicester Square","Piccadilly Circus",
  "Green Park","Hyde Park Corner","Knightsbridge","South Kensington","Gloucester Road","Earl's Court"]).
percorso("Victoria",0,["King's Cross St. Pancras","Euston","Warren Street","Oxford Circus","Green Park","Victoria","Pimlico"]).
percorso("Waterloo & City",0,["Bank","Waterloo"])

percorso(Linea,1,LR) :- percorso(Linea,0,L), reverse(L,LR).

% tratta(NomeLinea, Dir, StazionePartenza, StazioneArrivo)
tratta(Linea,Dir,SP,SA) :- percorso(Linea,Dir,LF), member_pair(SP,SA,LF).

member_pair(X,Y,[X,Y|_]).
member_pair(X,Y,[_,Z|Rest]) :- member_pair(X,Y,[Z|Rest]).


% stazione(Stazione, Coord1, Coord2)

stazione("Temple", -0.112643564, 51.5104742).
stazione("Blackfriars", -0.102020251, 51.51111447).
stazione("Mansion House", -0.092495313, 51.51130597).
stazione("Cannon Street", -0.088801035, 51.51096254).
stazione("Monument", -0.084502291, 51.51020898).
stazione("Tower Hill", -0.074913869, 51.50943419).
stazione("Aldgate", -0.0742363, 51.51398203).
stazione("Liverpool Street", -0.081601363, 51.5168424).
stazione("Moorgate", -0.087700241, 51.5178533).
stazione("Barbican", -0.097189673, 51.51969921).
stazione("Farringdon", -0.103582415, 51.51996102).
stazione("King's Cross St. Pancras", -0.123168404, 51.52927728).
stazione("Euston Square", -0.134270582, 51.52512499).
stazione("Great Portland Street", -0.142685711, 51.52333822).
stazione("Baker Street", -0.155454387, 51.52249387).
stazione("Edgware Road", -0.166170742, 51.51936413).
stazione("Paddington", -0.173789485, 51.51499491).
stazione("Bayswater", -0.186322701, 51.51181507).
stazione("High Street Kensington", -0.190607248, 51.49993492).
stazione("Gloucester Road", -0.182135121, 51.49397763).
stazione("South Kensington", -0.171564291, 51.49357736).
stazione("Victoria", -0.141485017, 51.49588954).
stazione("Pimlico", -0.132103672, 51.48856954).
stazione("Warren Street", -0.136735811, 51.52401887).
stazione("Queensway", -0.185538472, 51.50974305).
stazione("Hyde Park Corner", -0.152546395, 51.50224103).
stazione("Knightsbridge", -0.159863737, 51.50073061).
stazione("Leicester Square", -0.126725567, 51.51089472).
stazione("Covent Garden", -0.122759938, 51.51263471).
stazione("Russell Square", -0.122662273, 51.52255053).
stazione("Earl's Court", -0.19157701, 51.4914734).
stazione("Notting Hill Gate", -0.194491212, 51.5086469).
stazione("Lancaster Gate", -0.173843886, 51.51117805).
stazione("Marble Arch", -0.155755638, 51.51309055).
stazione("Bond Street", -0.148076884, 51.51387033).
stazione("Bank", -0.08729695, 51.51291511).
stazione("Oxford Circus", -0.140025246, 51.51481046).
stazione("Holborn", -0.1188087, 51.51706879).
stazione("Chancery Lane", -0.109960547, 51.5177395).
stazione("St. Paul's", -0.095907533, 51.51444286).
stazione("Paddington", -0.174388339, 51.51605291).
stazione("Embankment", -0.120562428, 51.50694137).
stazione("Westminster", -0.124052209, 51.50045311).
stazione("Euston", -0.132992071, 51.52757668).
stazione("Waterloo", -0.112818812, 51.50291418).
stazione("Green Park", -0.140937126, 51.50635747).
%stazione("Paddington (H&C Line)", -0.17719615, 51.51800497).
stazione("Piccadilly Circus", -0.132081484, 51.50955061).
stazione("Charing Cross", -0.125777173, 51.50686754).
stazione("Lambeth North", -0.110624882, 51.49833058).
%stazione("Edgware Road (Bakerloo)", -0.168645951, 51.51996099).
stazione("Marylebone", -0.162637346, 51.52165079).
stazione("Regent's Park", -0.144708117, 51.52277011).
stazione("Sloane Square", -0.15473274, 51.49182524).
stazione("St. James's Park", -0.132021543, 51.49905006).
%stazione("Goodge Street", -0.132736642, 51.52009307).
stazione("Tottenham Court Road", -0.128897348, 51.51594793).
stazione("Borough", -0.091702818, 51.50067969).
stazione("Old Street", -0.086025441, 51.52457628).
stazione("Angel", -0.103116359, 51.5309796).
%stazione("Aldgate East", -0.069540402, 51.51491653).
stazione("Southwark", -0.103788452, 51.50377646).
stazione("London Bridge", -0.088037808, 51.50455372).


fermata(Stazione,Linea) :- percorso(Linea,0,P), member(Stazione,P).


iniziale([at("Bayswater"),ground]).

finale([at("Piccadilly Circus"),ground]).
