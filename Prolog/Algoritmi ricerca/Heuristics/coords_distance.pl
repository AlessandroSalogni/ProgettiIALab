heuristic([at(SP),_], Costo) :- 
    finale([at(SA),_]), coords_distance(SP,SA,Costo).