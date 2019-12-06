%cambi(Linea1, Linea2, Dir, N_Cambi)

cambi("Bakerloo", "Central", 0, 1).
cambi("Bakerloo", "Circle", 0, 1).
cambi("Bakerloo", "District East-West", 0, 1).
cambi("Bakerloo", "District North-South", 0, 1).
cambi("Bakerloo", "Hammersmith & City", 0, 1).
cambi("Bakerloo", "Jubilee", 0, 1).
cambi("Bakerloo", "Metropolitan", 0, 1).
cambi("Bakerloo", "Northern East", 0, 1).
cambi("Bakerloo", "Northern West", 0, 1).
cambi("Bakerloo", "Piccadilly", 0, 1).
cambi("Bakerloo", "Victoria", 0, 1).
cambi("Bakerloo", "Waterloo & City", 0, 1).
cambi("Central", "Circle", 0, 1).
cambi("Central", "District East-West", 0, 1).
cambi("Central", "District North-South", 0, 1).
cambi("Central", "Hammersmith & City", 0, 1).
cambi("Central", "Jubilee", 0, 1).
cambi("Central", "Metropolitan", 0, 1).
cambi("Central", "Northern East", 0, 1).
cambi("Central", "Northern West", 0, 1).
cambi("Central", "Piccadilly", 0, 1).
cambi("Central", "Victoria", 0, 1).
cambi("Central", "Waterloo & City", 0, 1).
cambi("Circle", "District East-West", 0, 1).
cambi("Circle", "District North-South", 0, 1).
cambi("Circle", "Hammersmith & City", 0, 1).
cambi("Circle", "Jubilee", 0, 1).
cambi("Circle", "Metropolitan", 0, 1).
cambi("Circle", "Northern East", 0, 1).
cambi("Circle", "Northern West", 0, 1).
cambi("Circle", "Piccadilly", 0, 1).
cambi("Circle", "Victoria", 0, 1).
cambi("Circle", "Waterloo & City", 0, 2).
cambi("District East-West", "District North-South", 0, 1).
cambi("District East-West", "Hammersmith & City", 0, 1).
cambi("District East-West", "Jubilee", 0, 1).
cambi("District East-West", "Metropolitan", 0, 2).
cambi("District East-West", "Northern East", 0, 2).
cambi("District East-West", "Northern West", 0, 1).
cambi("District East-West", "Piccadilly", 0, 1).
cambi("District East-West", "Victoria", 0, 1).
cambi("District East-West", "Waterloo & City", 0, 2).
cambi("District North-South", "Hammersmith & City", 0, 1).
cambi("District North-South", "Jubilee", 0, 2).
cambi("District North-South", "Metropolitan", 0, 2).
cambi("District North-South", "Northern East", 0, 2).
cambi("District North-South", "Northern West", 0, 2).
cambi("District North-South", "Piccadilly", 0, 1).
cambi("District North-South", "Victoria", 0, 2).
cambi("District North-South", "Waterloo & City", 0, 2).
cambi("Hammersmith & City", "Jubilee", 0, 1).
cambi("Hammersmith & City", "Metropolitan", 0, 1).
cambi("Hammersmith & City", "Northern East", 0, 1).
cambi("Hammersmith & City", "Northern West", 0, 2).
cambi("Hammersmith & City", "Piccadilly", 0, 1).
cambi("Hammersmith & City", "Victoria", 0, 1).
cambi("Hammersmith & City", "Waterloo & City", 0, 2).
cambi("Jubilee", "Metropolitan", 0, 1).
cambi("Jubilee", "Northern East", 0, 1).
cambi("Jubilee", "Northern West", 0, 1).
cambi("Jubilee", "Piccadilly", 0, 1).
cambi("Jubilee", "Victoria", 0, 1).
cambi("Jubilee", "Waterloo & City", 0, 1).
cambi("Metropolitan", "Northern East", 0, 1).
cambi("Metropolitan", "Northern West", 0, 2).
cambi("Metropolitan", "Piccadilly", 0, 1).
cambi("Metropolitan", "Victoria", 0, 1).
cambi("Metropolitan", "Waterloo & City", 0, 2).
cambi("Northern East", "Northern West", 0, 1).
cambi("Northern East", "Piccadilly", 0, 1).
cambi("Northern East", "Victoria", 0, 1).
cambi("Northern East", "Waterloo & City", 0, 1).
cambi("Northern West", "Piccadilly", 0, 1).
cambi("Northern West", "Victoria", 0, 1).
cambi("Northern West", "Waterloo & City", 0, 1).
cambi("Piccadilly", "Victoria", 0, 1).
cambi("Piccadilly", "Waterloo & City", 0, 2).
cambi("Victoria", "Waterloo & City", 0, 2).

cambi(Linea1, Linea2, 1, Cambi) :- cambi(Linea2, Linea1, 0, Cambi).
