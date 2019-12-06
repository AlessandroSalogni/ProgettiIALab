%cambi(Linea1, Linea2, Dir, N_Cambi)

cambi("Bakerloo", "Central", 0, 1).
cambi("Bakerloo", "Circle", 0, 1).
cambi("Bakerloo", "Jubilee", 0, 1).
cambi("Bakerloo", "Northern", 0, 2).
cambi("Bakerloo", "Piccadilly", 0, 1).
cambi("Bakerloo", "Victoria", 0, 1).
cambi("Bakerloo", "Waterloo & City", 0, 1).
cambi("Central", "Circle", 0, 1).
cambi("Central", "Jubilee", 0, 1).
cambi("Central", "Northern", 0, 1).
cambi("Central", "Piccadilly", 0, 1).
cambi("Central", "Victoria", 0, 1).
cambi("Central", "Waterloo & City", 0, 1).
cambi("Circle", "Jubilee", 0, 1).
cambi("Circle", "Northern", 0, 1).
cambi("Circle", "Piccadilly", 0, 1).
cambi("Circle", "Victoria", 0, 1).
cambi("Circle", "Waterloo & City", 0, 2).
cambi("Jubilee", "Northern", 0, 1).
cambi("Jubilee", "Piccadilly", 0, 1).
cambi("Jubilee", "Victoria", 0, 1).
cambi("Jubilee", "Waterloo & City", 0, 1).
cambi("Northern", "Piccadilly", 0, 1).
cambi("Northern", "Victoria", 0, 1).
cambi("Northern", "Waterloo & City", 0, 1).
cambi("Piccadilly", "Victoria", 0, 1).
cambi("Piccadilly", "Waterloo & City", 0, 2).
cambi("Victoria", "Waterloo & City", 0, 2).

cambi(Linea1, Linea2, 1, Cambi) :- cambi(Linea2, Linea1, 0, Cambi).
