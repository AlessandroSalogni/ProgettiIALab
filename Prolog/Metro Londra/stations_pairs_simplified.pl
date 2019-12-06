/* Bakerloo */
coppie_stazioni("Edgware Road", "Marylebone", 0).
coppie_stazioni("Marylebone", "Baker Street", 0).
coppie_stazioni("Baker Street", "Regent's Park", 0).
coppie_stazioni("Regent's Park", "Oxford Circus", 0).
coppie_stazioni("Oxford Circus", "Piccadilly Circus", 0).
coppie_stazioni("Piccadilly Circus", "Charing Cross", 0).
coppie_stazioni("Waterloo", "Lambeth North", 0).
coppie_stazioni("Lambeth North", "Elephant & Castle", 0).

/* Central */
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

/* Victoria*/
coppie_stazioni("Warren Street", "Oxford Circus", 0).
coppie_stazioni("Oxford Circus", "Green Park", 0).
coppie_stazioni("Green Park", "Victoria", 0).
coppie_stazioni("Victoria", "Pimlico", 0).
coppie_stazioni("Pimlico", "Vauxhall", 0).

/* Waterloo & City */
coppie_stazioni("Waterloo", "Bank", 0).

/* Jubilee */
coppie_stazioni("Baker Street", "Bond Street", 0).
coppie_stazioni("Bond Street", "Green Park", 0).
coppie_stazioni("Green Park", "Westminster", 0).
coppie_stazioni("Westminster", "Waterloo", 0).
coppie_stazioni("Waterloo", "Southwark", 0).
coppie_stazioni("Southwark", "London Bridge", 0).

/* Northern */
coppie_stazioni("Euston", "Warren Street", 0).
coppie_stazioni("Charing Cross", "Embankment", 0).
coppie_stazioni("Embankment", "Waterloo", 0).
coppie_stazioni("Euston", "King's Cross St. Pancras", 0).
coppie_stazioni("King's Cross St. Pancras", "Angel", 0).
coppie_stazioni("Angel", "Old Street", 0).
coppie_stazioni("Old Street", "Moorgate", 0).
coppie_stazioni("Moorgate", "Bank", 0).
coppie_stazioni("Bank", "London Bridge", 0).
coppie_stazioni("London Bridge", "Borough", 0).
coppie_stazioni("Borough", "Elephant & Castle", 0).

/* Piccadilly */
coppie_stazioni("South Kensington", "Knightsbridge", 0).
coppie_stazioni("Knightsbridge", "Hyde Park Corner", 0).
coppie_stazioni("Hyde Park Corner", "Green Park", 0).
coppie_stazioni("Green Park", "Piccadilly Circus", 0).
coppie_stazioni("Piccadilly Circus", "Leicester Square", 0).
coppie_stazioni("Leicester Square", "Covent Garden", 0).
coppie_stazioni("Covent Garden", "Holborn", 0).
coppie_stazioni("Holborn", "Russell Square", 0).
coppie_stazioni("Russell Square", "King's Cross St. Pancras", 0).

/* Hammersmith & City */
coppie_stazioni("Baker Street", "Great Portland Street", 0).
coppie_stazioni("Great Portland Street", "Euston Square", 0).
coppie_stazioni("Euston Square", "King's Cross St. Pancras", 0).
coppie_stazioni("King's Cross St. Pancras", "Farringdon", 0).
coppie_stazioni("Farringdon", "Barbican", 0).
coppie_stazioni("Barbican", "Moorgate", 0).
coppie_stazioni("Moorgate", "Liverpool Street", 0).

/* Circle */
coppie_stazioni("High Street Kensington", "Gloucester Road", 0).
coppie_stazioni("Tower Hill", "Aldgate", 0).
coppie_stazioni("Aldgate", "Liverpool Street", 0).
coppie_stazioni("Baker Street", "Edgware Road", 0).

/* District */
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

coppie_stazioni(SP, SA, 1) :- coppie_stazioni(SA, SP, 0).