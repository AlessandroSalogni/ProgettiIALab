heuristic([at(SP),_], Costo) :- ash([nodo(SP, [], 0, 0)], Costo, []).

ash([nodo(SA, _, CostoAzPerS, _)|_], CostoAzPerS, _) :-  finale([at(SA),_]), !.
ash([nodo(S, _, CostoAzPerS, EurDaS)|Tail], Soluzione, Vis) :-
  findall(Az, applicabile_heuristic(Az, S), ListaAzApplicabili),
  expand_children_ash(nodo(S, [], CostoAzPerS, EurDaS), ListaAzApplicabili, Vis, ListaFigli),
  priority_queue(Tail, ListaFigli, NuovaCoda),
  ash(NuovaCoda, Soluzione, [nodo(S, CostoAzPerS)|Vis]).

expand_children_ash(_, [], _, []).
expand_children_ash(nodo(S, _, CostoAzPerS, EurDaS), [Az|AltreAz], Vis, [nodo(S_Nuovo, [], CostoAzPerSNuovo, EurDaSNuovo)|FigliTail]) :-
  trasforma_heuristic(Az, S, S_Nuovo),
  costo_heuristic(Az, Costo),
  CostoAzPerSNuovo is CostoAzPerS + Costo,
  revisit_node(nodo(S_Nuovo, CostoAzPerSNuovo), Vis, NuoviVis), !,
  coords_distance_heuristic(S_Nuovo, EurDaSNuovo),
  expand_children_ash(nodo(S, [], CostoAzPerS, EurDaS), AltreAz, NuoviVis, FigliTail).
expand_children_ash(Nodo, [_|AltreAz], Vis, FigliTail) :- expand_children_ash(Nodo, AltreAz, Vis, FigliTail).

revisit_node(_, [], []).
revisit_node(nodo(S, CostoAzPerS), [nodo(S, CostoAzPerSVis)|AltriVis], AltriVis) :- !, CostoAzPerS < CostoAzPerSVis.
revisit_node(nodo(S, CostoAzPerS), [nodo(SVis, CostoAzPerSVis)|AltriVis], [nodo(SVis, CostoAzPerSVis)|NuoviVis]) :-
  revisit_node(nodo(S, CostoAzPerS), AltriVis, NuoviVis).

coords_distance_heuristic(SP, Costo) :-
  finale([at(SA),_]),
  coords_distance(SP,SA,Costo).

applicabile_heuristic(vai(SP, SA, Dir), SP) :- coppie_stazioni(SP, SA, Dir).
trasforma_heuristic(vai(SP, SA, _), SP, SA).
costo_heuristic(vai(SP, SA, _), Costo) :- coords_distance(SP,SA,Costo).


/* Bakerloo */
% coppie_stazioni("Harrow & Wealdstone", "Kenton", 0).
% coppie_stazioni("Kenton", "South Kenton", 0).
% coppie_stazioni("South Kenton", "North Wembley", 0).
% coppie_stazioni("North Wembley", "Wembley Central", 0).
% coppie_stazioni("Wembley Central", "Stonebridge Park", 0).
coppie_stazioni("Stonebridge Park", "Harlesden", 0).
coppie_stazioni("Harlesden", "Willesden Junction", 0).
coppie_stazioni("Willesden Junction", "Kensal Green", 0).
coppie_stazioni("Kensal Green", "Queen's Park", 0).
coppie_stazioni("Queen's Park", "Kilburn Park", 0).
coppie_stazioni("Kilburn Park", "Maida Vale", 0).
coppie_stazioni("Maida Vale", "Warwick Avenue", 0).
coppie_stazioni("Warwick Avenue", "Paddington", 0).
coppie_stazioni("Edgware Road", "Marylebone", 0).
coppie_stazioni("Marylebone", "Baker Street", 0).
coppie_stazioni("Baker Street", "Regent's Park", 0).
coppie_stazioni("Regent's Park", "Oxford Circus", 0).
coppie_stazioni("Oxford Circus", "Piccadilly Circus", 0).
coppie_stazioni("Piccadilly Circus", "Charing Cross", 0).
coppie_stazioni("Waterloo", "Lambeth North", 0).
coppie_stazioni("Lambeth North", "Elephant & Castle", 0).

/* Central */
% coppie_stazioni("West Ruislip", "Ruislip Gardens", 0).
% coppie_stazioni("Ruislip Gardens", "South Ruislip", 0).
% coppie_stazioni("South Ruislip", "Northolt", 0).
% coppie_stazioni("Northolt", "Greenford", 0).
% coppie_stazioni("Greenford", "Perivale", 0).
% coppie_stazioni("Perivale", "Hanger Lane", 0).
% coppie_stazioni("Hanger Lane", "North Acton", 0).
coppie_stazioni("Ealing Broadway", "West Acton", 0).
coppie_stazioni("West Acton", "North Acton", 0).
coppie_stazioni("North Acton", "East Acton", 0).
coppie_stazioni("East Acton", "White City", 0).
coppie_stazioni("White City", "Shepherd's Bush", 0).
coppie_stazioni("Shepherd's Bush", "Holland Park", 0).
coppie_stazioni("Holland Park", "Notting Hill Gate", 0).
coppie_stazioni("Notting Hill Gate", "Queensway", 0).
coppie_stazioni("Queensway", "Lancaster Gate", 0).
coppie_stazioni("Lancaster Gate", "Marble Arch", 0).
coppie_stazioni("Marble Arch", "Bond Street", 0).
coppie_stazioni("Bond Street", "Oxford Circus", 0).
coppie_stazioni("Oxford Circus", "Tottenham Court Road", 0).
coppie_stazioni("Tottenham Court Road", "Holborn", 0).
coppie_stazioni("Holborn", "Chancery Lane", 0).
coppie_stazioni("Chancery Lane", "St. Paul's", 0).
coppie_stazioni("St. Paul's", "Bank", 0).
coppie_stazioni("Bank", "Liverpool Street", 0).
coppie_stazioni("Liverpool Street", "Bethnal Green", 0).
coppie_stazioni("Bethnal Green", "Mile End", 0).
coppie_stazioni("Mile End", "Stratford", 0).
coppie_stazioni("Stratford", "Leyton", 0).
% coppie_stazioni("Leyton", "Leytonstone", 0).
% coppie_stazioni("Leytonstone", "Wanstead", 0).
% coppie_stazioni("Wanstead", "Redbridge", 0).
% coppie_stazioni("Redbridge", "Gants Hill", 0).
% coppie_stazioni("Gants Hill", "Newbury Park", 0).
% coppie_stazioni("Newbury Park", "Barkingside", 0).
% coppie_stazioni("Barkingside", "Fairlop", 0).
% coppie_stazioni("Fairlop", "Hainault", 0).
% coppie_stazioni("Leytonstone", "Snaresbrook", 0).
% coppie_stazioni("Snaresbrook", "South Woodford", 0).
% coppie_stazioni("South Woodford", "Woodford", 0).
% coppie_stazioni("Roding Valley", "Woodford", 0).
% coppie_stazioni("Chigwell", "Roding Valley", 0).
% coppie_stazioni("Grange Hill", "Chigwell", 0).
% coppie_stazioni("Hainault", "Grange Hill", 0).
% coppie_stazioni("Woodford", "Buckhurst Hill", 0).
% coppie_stazioni("Buckhurst Hill", "Loughton", 0).
% coppie_stazioni("Loughton", "Debden", 0).
% coppie_stazioni("Debden", "Theydon Bois", 0).
% coppie_stazioni("Theydon Bois", "Epping", 0).

/* Victoria*/
coppie_stazioni("Walthamstow Central", "Blackhorse Road", 0).
coppie_stazioni("Blackhorse Road", "Tottenham Hale", 0).
coppie_stazioni("Tottenham Hale", "Seven Sisters", 0).
coppie_stazioni("Seven Sisters", "Finsbury Park", 0).
coppie_stazioni("Finsbury Park", "Highbury & Islington", 0).
coppie_stazioni("Highbury & Islington", "King's Cross St. Pancras", 0).
coppie_stazioni("Warren Street", "Oxford Circus", 0).
coppie_stazioni("Oxford Circus", "Green Park", 0).
coppie_stazioni("Green Park", "Victoria", 0).
coppie_stazioni("Victoria", "Pimlico", 0).
coppie_stazioni("Pimlico", "Vauxhall", 0).
coppie_stazioni("Vauxhall", "Stockwell", 0).
coppie_stazioni("Stockwell", "Brixton", 0).

/* Waterloo & City */
coppie_stazioni("Waterloo", "Bank", 0).

/* Jubilee */
% coppie_stazioni("Stanmore", "Canons Park", 0).
% coppie_stazioni("Canons Park", "Queensbury", 0).
% coppie_stazioni("Queensbury", "Kingsbury", 0).
% coppie_stazioni("Kingsbury", "Wembley Park", 0).
% coppie_stazioni("Wembley Park", "Neasden", 0).
coppie_stazioni("Neasden", "Dollis Hill", 0).
coppie_stazioni("Dollis Hill", "Willesden Green", 0).
coppie_stazioni("Willesden Green", "Kilburn", 0).
coppie_stazioni("Kilburn", "West Hampstead", 0).
coppie_stazioni("West Hampstead", "Finchley Road", 0).
coppie_stazioni("Finchley Road", "Swiss Cottage", 0).
coppie_stazioni("Swiss Cottage", "St. John's Wood", 0).
coppie_stazioni("St. John's Wood", "Baker Street", 0).
coppie_stazioni("Baker Street", "Bond Street", 0).
coppie_stazioni("Bond Street", "Green Park", 0).
coppie_stazioni("Green Park", "Westminster", 0).
coppie_stazioni("Westminster", "Waterloo", 0).
coppie_stazioni("Waterloo", "Southwark", 0).
coppie_stazioni("Southwark", "London Bridge", 0).
coppie_stazioni("London Bridge", "Bermondsey", 0).
coppie_stazioni("Bermondsey", "Canada Water", 0).
coppie_stazioni("Canada Water", "Canary Wharf", 0).
coppie_stazioni("Canary Wharf", "North Greenwich", 0).
coppie_stazioni("North Greenwich", "Canning Town", 0).
coppie_stazioni("Canning Town", "West Ham", 0).
coppie_stazioni("West Ham", "Stratford", 0).

/* Northern */
% coppie_stazioni("Edgware", "Burnt Oak", 0).
% coppie_stazioni("Burnt Oak", "Colindale", 0).
% coppie_stazioni("Colindale", "Hendon Central", 0).
coppie_stazioni("Hendon Central", "Brent Cross", 0).
coppie_stazioni("Brent Cross", "Golders Green", 0).
coppie_stazioni("Golders Green", "Hampstead", 0).
coppie_stazioni("Hampstead", "Belsize Park", 0).
coppie_stazioni("Belsize Park", "Chalk Farm", 0).
coppie_stazioni("Chalk Farm", "Camden Town", 0).
% coppie_stazioni("High Barnet", "Totteridge & Whetstone", 0).
% coppie_stazioni("Totteridge & Whetstone", "Woodside Park", 0).
% coppie_stazioni("Woodside Park", "West Finchley", 0).
% coppie_stazioni("West Finchley", "Finchley Central", 0).
% coppie_stazioni("Mill Hill East", "Finchley Central", 0).
% coppie_stazioni("Finchley Central", "East Finchley", 0).
coppie_stazioni("East Finchley", "Highgate", 0).
coppie_stazioni("Highgate", "Archway", 0).
coppie_stazioni("Archway", "Tufnell Park", 0).
coppie_stazioni("Tufnell Park", "Kentish Town", 0).
coppie_stazioni("Kentish Town", "Camden Town", 0).
coppie_stazioni("Camden Town", "Mornington Crescent", 0).
coppie_stazioni("Mornington Crescent", "Euston", 0).
coppie_stazioni("Euston", "Warren Street", 0).
coppie_stazioni("Warren Street", "Goodge Street", 0).
coppie_stazioni("Goodge Street", "Tottenham Court Road", 0).
coppie_stazioni("Tottenham Court Road", "Leicester Square", 0).
coppie_stazioni("Leicester Square", "Charing Cross", 0).
coppie_stazioni("Charing Cross", "Embankment", 0).
coppie_stazioni("Embankment", "Waterloo", 0).
coppie_stazioni("Waterloo", "Kennington", 0).
coppie_stazioni("Camden Town", "Euston", 0).
coppie_stazioni("Euston", "King's Cross St. Pancras", 0).
coppie_stazioni("King's Cross St. Pancras", "Angel", 0).
coppie_stazioni("Angel", "Old Street", 0).
coppie_stazioni("Old Street", "Moorgate", 0).
coppie_stazioni("Moorgate", "Bank", 0).
coppie_stazioni("Bank", "London Bridge", 0).
coppie_stazioni("London Bridge", "Borough", 0).
coppie_stazioni("Borough", "Elephant & Castle", 0).
coppie_stazioni("Elephant & Castle", "Kennington", 0).
coppie_stazioni("Kennington", "Oval", 0).
coppie_stazioni("Oval", "Stockwell", 0).
coppie_stazioni("Stockwell", "Clapham North", 0).
coppie_stazioni("Clapham North", "Clapham Common", 0).
coppie_stazioni("Clapham Common", "Clapham South", 0).
coppie_stazioni("Clapham South", "Balham", 0).
coppie_stazioni("Balham", "Tooting Bec", 0).
coppie_stazioni("Tooting Bec", "Tooting Broadway", 0).
coppie_stazioni("Tooting Broadway", "Colliers Wood", 0).
coppie_stazioni("Colliers Wood", "South Wimbledon", 0).
% coppie_stazioni("South Wimbledon", "Morden", 0).

/* Piccadilly */
% coppie_stazioni("Rayners Lane", "South Harrow", 0).
% coppie_stazioni("South Harrow", "Sudbury Hill", 0).
% coppie_stazioni("Sudbury Hill", "Sudbury Town", 0).
% coppie_stazioni("Sudbury Town", "Alperton", 0).
% coppie_stazioni("Alperton", "Park Royal", 0).
coppie_stazioni("Park Royal", "North Ealing", 0).
coppie_stazioni("North Ealing", "Ealing Common", 0).
% coppie_stazioni("Heathrow 123", "Hatton Cross", 0).
% coppie_stazioni("Hatton Cross", "Hounslow West", 0).
% coppie_stazioni("Hounslow West", "Hounslow Central", 0).
% coppie_stazioni("Hounslow Central", "Hounslow East", 0).
% coppie_stazioni("Hounslow East", "Osterley", 0).
% coppie_stazioni("Osterley", "Boston Manor", 0).
% coppie_stazioni("Boston Manor", "Northfields", 0).
% coppie_stazioni("Northfields", "South Ealing", 0).
% coppie_stazioni("South Ealing", "Acton Town", 0).
coppie_stazioni("Acton Town", "Hammersmith", 0).
coppie_stazioni("Barons Court", "Earl's Court", 0).
coppie_stazioni("South Kensington", "Knightsbridge", 0).
coppie_stazioni("Knightsbridge", "Hyde Park Corner", 0).
coppie_stazioni("Hyde Park Corner", "Green Park", 0).
coppie_stazioni("Green Park", "Piccadilly Circus", 0).
coppie_stazioni("Piccadilly Circus", "Leicester Square", 0).
coppie_stazioni("Leicester Square", "Covent Garden", 0).
coppie_stazioni("Covent Garden", "Holborn", 0).
coppie_stazioni("Holborn", "Russell Square", 0).
coppie_stazioni("Russell Square", "King's Cross St. Pancras", 0).
coppie_stazioni("King's Cross St. Pancras", "Caledonian Road", 0).
coppie_stazioni("Caledonian Road", "Holloway Road", 0).
coppie_stazioni("Holloway Road", "Arsenal", 0).
coppie_stazioni("Arsenal", "Finsbury Park", 0).
coppie_stazioni("Finsbury Park", "Manor House", 0).
coppie_stazioni("Manor House", "Turnpike Lane", 0).
coppie_stazioni("Turnpike Lane", "Wood Green", 0).
coppie_stazioni("Wood Green", "Bounds Green", 0).
% coppie_stazioni("Bounds Green", "Arnos Grove", 0).
% coppie_stazioni("Arnos Grove", "Southgate", 0).
% coppie_stazioni("Southgate", "Oakwood", 0).
% coppie_stazioni("Oakwood", "Cockfosters", 0).

/* Metropolitan */
coppie_stazioni("Baker Street", "Finchley Road", 0).
% coppie_stazioni("Finchley Road", "Wembley Park", 0).
% coppie_stazioni("Wembley Park", "Preston Road", 0).
% coppie_stazioni("Preston Road", "Northwick Park", 0).
% coppie_stazioni("Northwick Park", "Harrow-on-the-hill", 0).
% coppie_stazioni("Finchley Road", "Harrow-on-the-hill", 0).
% coppie_stazioni("Harrow-on-the-hill", "West Harrow", 0).
% coppie_stazioni("West Harrow", "Rayners Lane", 0).
% coppie_stazioni("Rayners Lane", "Eastcote", 0).
% coppie_stazioni("Eastcote", "Ruislip Manor", 0).
% coppie_stazioni("Ruislip Manor", "Ruislip", 0).
% coppie_stazioni("Ruislip", "Ickenham", 0).
% coppie_stazioni("Ickenham", "Hillingdon", 0).
% coppie_stazioni("Hillingdon", "Uxbridge", 0).
% coppie_stazioni("Harrow-on-the-hill", "North Harrow", 0).
% coppie_stazioni("North Harrow", "Pinner", 0).
% coppie_stazioni("Pinner", "Northwood Hills", 0).
% coppie_stazioni("Northwood Hills", "Northwood", 0).
% coppie_stazioni("Northwood", "Moor Park", 0).
% coppie_stazioni("Harrow-on-the-hill", "Moor Park", 0).
% coppie_stazioni("Moor Park", "Croxley", 0).
% coppie_stazioni("Croxley", "Watford", 0).
% coppie_stazioni("Moor Park", "Rickmansworth", 0).
% coppie_stazioni("Rickmansworth", "Chorleywood", 0).
% coppie_stazioni("Chorleywood", "Chalfont & Latimer", 0).
% coppie_stazioni("Chalfont & Latimer", "Chesham", 0).
% coppie_stazioni("Chalfont & Latimer", "Amersham", 0).

/* Hammersmith & City */
coppie_stazioni("Hammersmith", "Goldhawk Road", 0).
coppie_stazioni("Goldhawk Road", "Shepherd's Bush Market", 0).
coppie_stazioni("Shepherd's Bush Market", "Latimer Road", 0).
coppie_stazioni("Latimer Road", "Ladbroke Grove", 0).
coppie_stazioni("Ladbroke Grove", "Westbourne Park", 0).
coppie_stazioni("Westbourne Park", "Royal Oak", 0).
coppie_stazioni("Royal Oak", "Paddington", 0).
coppie_stazioni("Baker Street", "Great Portland Street", 0).
coppie_stazioni("Great Portland Street", "Euston Square", 0).
coppie_stazioni("Euston Square", "King's Cross St. Pancras St Pancras", 0).
coppie_stazioni("King's Cross St. Pancras St Pancras", "Farringdon", 0).
coppie_stazioni("Farringdon", "Barbican", 0).
coppie_stazioni("Barbican", "Moorgate", 0).
coppie_stazioni("Moorgate", "Liverpool Street", 0).
coppie_stazioni("Liverpool Street", "Aldgate East", 0).

/* Circle */
coppie_stazioni("High Street Kensington", "Gloucester Road", 0).
coppie_stazioni("Tower Hill", "Aldgate", 0).
coppie_stazioni("Aldgate", "Liverpool Street", 0).
coppie_stazioni("Baker Street", "Edgware Road", 0).

/* District */
% coppie_stazioni("Upminster", "Upminster Bridge", 0).
% coppie_stazioni("Upminster Bridge", "Hornchurch", 0).
% coppie_stazioni("Hornchurch", "Elm Park", 0).
% coppie_stazioni("Elm Park", "Dagenham East", 0).
% coppie_stazioni("Dagenham East", "Dagenham Heathway", 0).
% coppie_stazioni("Dagenham Heathway", "Becontree", 0).
% coppie_stazioni("Becontree", "Upney", 0).
% coppie_stazioni("Upney", "Barking", 0).
% coppie_stazioni("Barking", "East Ham", 0).
% coppie_stazioni("East Ham", "Upton Park", 0).
coppie_stazioni("Upton Park", "Plaistow", 0).
coppie_stazioni("Plaistow", "West Ham", 0).
coppie_stazioni("West Ham", "Bromley By Bow", 0).
coppie_stazioni("Bromley By Bow", "Bow Road", 0).
coppie_stazioni("Bow Road", "Mile End", 0).
coppie_stazioni("Mile End", "Stepney Green", 0).
coppie_stazioni("Stepney Green", "Whitechapel", 0).
coppie_stazioni("Whitechapel", "Aldgate East", 0).
coppie_stazioni("Aldgate East", "Tower Hill", 0).
coppie_stazioni("Tower Hill", "Monument", 0).
coppie_stazioni("Monument", "Cannon Street", 0).
coppie_stazioni("Cannon Street", "Mansion House", 0).
coppie_stazioni("Mansion House", "Blackfriars", 0).
coppie_stazioni("Blackfriars", "Temple", 0).
coppie_stazioni("Temple", "Embankment", 0).
coppie_stazioni("Embankment", "Westminster", 0).
coppie_stazioni("Westminster", "St. James's Park", 0).
coppie_stazioni("St. James's Park", "Victoria", 0).
coppie_stazioni("Victoria", "Sloane Square", 0).
coppie_stazioni("Sloane Square", "South Kensington", 0).
coppie_stazioni("South Kensington", "Gloucester Road", 0).
coppie_stazioni("Gloucester Road", "Earl's Court", 0).
coppie_stazioni("Edgware Road", "Paddington", 0).
coppie_stazioni("Paddington", "Bayswater", 0).
coppie_stazioni("Bayswater", "Notting Hill Gate", 0).
coppie_stazioni("Notting Hill Gate", "High Street Kensington", 0).
coppie_stazioni("High Street Kensington", "Earl's Court", 0).
% coppie_stazioni("Earl's Court", "Kensington (olympia)", 0).
coppie_stazioni("Earl's Court", "West Brompton", 0).
coppie_stazioni("West Brompton", "Fulham Broadway", 0).
coppie_stazioni("Fulham Broadway", "Parsons Green", 0).
coppie_stazioni("Parsons Green", "Putney Bridge", 0).
coppie_stazioni("Putney Bridge", "East Putney", 0).
coppie_stazioni("East Putney", "Southfields", 0).
coppie_stazioni("Southfields", "Wimbledon Park", 0).
coppie_stazioni("Wimbledon Park", "Wimbledon", 0).
coppie_stazioni("Earl's Court", "West Kensington", 0).
coppie_stazioni("West Kensington", "Barons Court", 0).
coppie_stazioni("Barons Court", "Hammersmith", 0).
coppie_stazioni("Hammersmith", "Ravenscourt Park", 0).
coppie_stazioni("Ravenscourt Park", "Stamford Brook", 0).
coppie_stazioni("Stamford Brook", "Turnham Green", 0).
coppie_stazioni("Turnham Green", "Chiswick Park", 0).
coppie_stazioni("Chiswick Park", "Acton Town", 0).
coppie_stazioni("Acton Town", "Ealing Common", 0).
coppie_stazioni("Ealing Common", "Ealing Broadway", 0).
% coppie_stazioni("Turnham Green", "Gunnersbury", 0).
% coppie_stazioni("Gunnersbury", "Kew Gardens", 0).
% coppie_stazioni("Kew Gardens", "Richmond", 0).

coppie_stazioni(SP, SA, 1) :- coppie_stazioni(SA, SP, 0).
