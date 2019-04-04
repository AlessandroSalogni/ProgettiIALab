% percorso(Linea, Dir, ListaFermate)

percorso("Bakerloo",0,["Kensal Green","Queen's Park","Kilburn Park","Maida Vale","Warwick Avenue","Paddington","Edgware Road",
  "Marylebone","Baker Street","Regent's Park","Oxford Circus","Piccadilly Circus","Charing Cross","Embankment","Waterloo",
  "Lambeth North","Elephant & Castle"]).
percorso("Central",0,["East Acton","White City","Shepherd's Bush","Holland Park","Notting Hill Gate","Queensway","Lancaster Gate",
  "Marble Arch","Bond Street","Oxford Circus","Tottenham Court Road","Holborn","Chancery Lane","St. Paul's","Bank","Liverpool Street",
  "Bethnal Green","Mile End"]).
percorso("Circle",0,["Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington","Gloucester Road",
  "High Street Kensington","Notting Hill Gate","Bayswater","Paddington","Edgware Road","Baker Street","Great Portland Street",
  "Euston Square","King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate","Tower Hill","Monument",
  "Cannon Street","Mansion House","Blackfriars","Temple","Embankment"]). %Pensare bene alla lista circolare
percorso("District East-West",0,["Bow Road","Mile End","Stepney Green","Whitechapel","Aldgate East","Tower Hill","Monument","Cannon Street",
  "Mansion House","Blackfriars","Temple","Embankment","Westminster","St. James's Park","Victoria","Sloane Square","South Kensington",
  "Gloucester Road","Earl's Court","West Kensington","Barons Court","Hammersmith","Ravenscourt Park","Stamford Brook"]).
percorso("District North-South",0,["Edgware Road","Paddington","Bayswater","Notting Hill Gate","High Street Kensington","Earl's Court",
  "West Brompton","Fulham Broadway","Parsons Green","Putney Bridge","East Putney"]).
percorso("Hammersmith & City",0,["Hammersmith","Goldhawk Road","Shepherd's Bush Market","Latimer Road","Ladbroke Grove",
  "Westbourne Park","Royal Oak","Paddington","Edgware Road","Baker Street","Great Portland Street","Euston Square",
  "King's Cross St. Pancras","Farringdon","Barbican","Moorgate","Liverpool Street","Aldgate East","Whitechapel",
  "Stepney Green","Mile End","Bow Road"]).
percorso("Jubilee",0,["Kilburn","West Hampstead","Finchley Road","Swiss Cottage","St. John's Wood","Baker Street","Bond Street",
  "Green Park","Westminster","Waterloo","Southwark","London Bridge","Bermondsey","Canada Water","Canary Wharf"]).
percorso("Metropolitan",0,["Finchley Road","Baker Street","Great Portland Street","Euston Square","King's Cross St. Pancras","Farringdon",
  "Barbican","Moorgate","Liverpool Street","Aldgate"]).
percorso("Northern East",0,["Archway","Tufnell Park","Kentish Town","Camden Town","Euston","King's Cross St. Pancras","Angel","Old Street",
  "Moorgate","Bank","London Bridge","Borough","Elephant & Castle","Kennington","Oval","Stockwell","Clapham North",
  "Clapham Common","Clapham South"]).
percorso("Northern West",0,["Hampstead","Belsize Park","Chalk Farm","Camden Town","Mornington Crescent","Euston","Warren Street",
  "Goodge Street","Tottenham Court Road","Leicester Square","Charing Cross","Embankment","Waterloo","Kennington","Oval","Stockwell",
  "Clapham North","Clapham Common","Clapham South"]).
percorso("Piccadilly",0,["Manor House","Finsbury Park","Arsenal","Holloway Road","Caledonian Road","King's Cross St. Pancras",
  "Russell Square","Holborn","Covent Garden","Leicester Square","Piccadilly Circus","Green Park","Hyde Park Corner",
  "Knightsbridge","South Kensington","Gloucester Road","Earl's Court","Barons Court","Hammersmith"]).
percorso("Victoria",0,["Finsbury Park","Highbury & Islington","King's Cross St. Pancras","Euston","Warren Street","Oxford Circus",
  "Green Park","Victoria","Pimlico","Vauxhall","Stockwell","Brixton"]).
percorso("Waterloo & City",0,["Bank","Waterloo"]).

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
stazione("Goodge Street", -0.132736642, 51.52009307).
stazione("Tottenham Court Road", -0.128897348, 51.51594793).
stazione("Borough", -0.091702818, 51.50067969).
stazione("Old Street", -0.086025441, 51.52457628).
stazione("Angel", -0.103116359, 51.5309796).
stazione("Aldgate East", -0.069540402, 51.51491653).
stazione("Southwark", -0.103788452, 51.50377646).
stazione("London Bridge", -0.088037808, 51.50455372).
stazione("East Putney", -0.209468663, 51.45863492).
stazione("Putney Bridge", -0.207131382, 51.46774182).
stazione("Parsons Green", -0.200166803, 51.47447238).
stazione("White City", -0.222866489, 51.51170695).
stazione("Shepherd's Bush", -0.217238899, 51.50384346).
stazione("Holland Park", -0.204062863, 51.50664438).
stazione("Brixton", -0.113288835, 51.46215131).
stazione("Vauxhall", -0.122646146, 51.48518446).
stazione("Highbury & Islington", -0.102125867, 51.54691824).
stazione("Caledonian Road", -0.116864262, 51.54801774).
stazione("Holloway Road", -0.111653531, 51.55225038).
stazione("Arsenal", -0.105674399, 51.55811105).
stazione("Manor House", -0.094452148, 51.57024769).
stazione("Shepherd's Bush Market", -0.224700725, 51.50558155).
stazione("Goldhawk Road", -0.225049873, 51.50148234).
stazione("Latimer Road", -0.216257476, 51.51295039).
stazione("Ladbroke Grove", -0.209304449, 51.51681261).
stazione("Royal Oak", -0.186186162, 51.51854003).
stazione("Westbourne Park", -0.199554267, 51.52041239).
stazione("Queen's Park", -0.204142926, 51.53347212).
stazione("Mile End", -0.032150165, 51.52472507).
stazione("Bethnal Green", -0.053074702, 51.52672839).
stazione("Kensington (Olympia)", -0.208533266, 51.49722528).
stazione("Finsbury Park", -0.105068129, 51.56406609).
stazione("Stockwell", -0.121436641, 51.47131386).
%stazione("Hammersmith (H&C Line)", -0.223334507, 51.49327356).
stazione("Kensal Green", -0.222882378, 51.5300656).
stazione("Elephant & Castle", -0.099577259, 51.4953253).
stazione("Warwick Avenue", -0.182005998, 51.52269118).
stazione("Maida Vale", -0.184228557, 51.52922219).
stazione("Kilburn Park", -0.192420271, 51.53444139).
stazione("Ravenscourt Park", -0.234181724, 51.49365752).
stazione("Hammersmith", -0.22144689, 51.49148885).
stazione("Kilburn", -0.203115567, 51.54644842).
stazione("West Hampstead", -0.188568627, 51.54629707).
stazione("Swiss Cottage", -0.173237239, 51.54319998).
stazione("Finchley Road", -0.179489511, 51.54672589).
stazione("Archway", -0.13344404, 51.56403452).
stazione("Clapham South", -0.145610374, 51.45272059).
stazione("Clapham Common", -0.135588991, 51.46169503).
stazione("Clapham North", -0.127754372, 51.4652144).
stazione("Belsize Park", -0.163016956, 51.54982085).
stazione("Hampstead", -0.17692039, 51.55608598).
stazione("Mornington Crescent", -0.137143461, 51.53419787).
stazione("Chalk Farm", -0.151037017, 51.54335257).
stazione("Camden Town", -0.141016888, 51.53872412).
stazione("Kentish Town", -0.13914119, 51.54978865).
stazione("Tufnell Park", -0.136858377, 51.5563398).
stazione("Oval", -0.110799082, 51.48132384).
stazione("Kennington", -0.104357247, 51.48782707).
stazione("East Acton", -0.245569272, 51.51609001).
stazione("Wood Lane", -0.221994162, 51.50963208).
stazione("West Kensington", -0.203860054, 51.49027946).
stazione("Barons Court", -0.213088174, 51.48978737).
stazione("Fulham Broadway", -0.193168686, 51.48025536).
stazione("West Brompton", -0.193973832, 51.48676791).
stazione("Stamford Brook", -0.244408726, 51.49440814).
stazione("Stepney Green", -0.044974603, 51.52135166).
stazione("Whitechapel", -0.059154123, 51.51902202).
stazione("Bow Road", -0.02358427, 51.52639287).
stazione("St. John's Wood", -0.172545248, 51.53469852).
stazione("Canada Water", -0.048372238, 51.49740822).
stazione("Bermondsey", -0.062745893, 51.49718984).
stazione("Canary Wharf", -0.016134819, 51.50291749).


fermata(Stazione,Linea) :- percorso(Linea,0,P), member(Stazione,P).


iniziale([at("Bayswater"),ground]).

finale([at("Piccadilly Circus"),ground]).
