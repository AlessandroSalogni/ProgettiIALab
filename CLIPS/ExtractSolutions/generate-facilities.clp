(defmodule GENERATE-FACILITIES (import MAIN ?ALL) (export ?ALL)) 

(deftemplate GENERATE-FACILITIES::facility
  (slot name (type STRING))
  (slot city (type STRING))
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (multislot rooms-available (type INTEGER) (range 0 ?VARIABLE)) 
  (multislot rooms-booked (type INTEGER) (range 0 ?VARIABLE)) 
  (multislot services (cardinality 0 ?VARIABLE))
)

(deffacts GENERATE-FACILITIES::facility-definition
  (facility (name "Vista Mare (MS)") (price 100) (city "Massa") (stars 4) (rooms-available 12) (rooms-booked 4) (services parking wifi pool tv spa room-service))
  (facility (name "Resort Miramare (MS)") (price 75) (city "Massa") (stars 3) (rooms-available 2) (rooms-booked 16) (services parking pet tv wifi))
  (facility (name "Ostello di Massa (MS)") (price 50) (city "Massa") (stars 2) (rooms-available 10) (rooms-booked 22) (services wifi tv))

  (facility (name "Hotel Cavour (TO)") (price 70) (city "Torino") (stars 3) (rooms-available 10) (rooms-booked 1) (services air-conditioning wifi pool tv room-service))
  (facility (name "Hotel Mazzini (TO)") (price 50) (city "Torino") (stars 2) (rooms-available 5) (rooms-booked 3) (services parking pool tv))
  (facility (name "Hotel Mucrone (TO)") (price 55) (city "Torino") (stars 2) (rooms-available 12) (rooms-booked 0) (services wifi tv))
  (facility (name "Avogadro Hostel (TO)") (price 15) (city "Torino") (stars 1) (rooms-available 3) (rooms-booked 2) (services parking))

  (facility (name "Garda resort (VR)") (price 130) (city "Verona") (stars 4) (rooms-available 22) (rooms-booked 0) (services parking wifi air-conditioning tv spa room-service pet))
  (facility (name "Ostello della gioventu (VR)") (price 30) (city "Verona") (stars 1) (rooms-available 0) (rooms-booked 10) (services pet))

  (facility (name "Bella vista (GE)") (price 80) (city "Genova") (stars 3) (rooms-available 20) (rooms-booked 4) (services parking wifi tv pool pet))
  (facility (name "Il porticciolo (GE)") (price 50) (city "Genova") (stars 2) (rooms-available 20) (rooms-booked 4) (services tv wifi))

  (facility (name "Al fresco (IM)") (price 30) (city "Imperia") (stars 1) (rooms-available 10) (rooms-booked 5) (services tv wifi))
  (facility (name "Al caldo (IM)") (price 30) (city "Imperia") (stars 2) (rooms-available 10) (rooms-booked 5) (services tv wifi))

  (facility (name "Al sole (SV)") (price 45) (city "Savona") (stars 2) (rooms-available 10) (rooms-booked 1) (services parking pet tv))

  (facility (name "La rocca (BO)") (price 80) (city "Bologna") (stars 3) (rooms-available 21) (rooms-booked 0) (services wifi tv room-service air-conditioning))
  (facility (name "La rossa (BO)") (price 50) (city "Bologna") (stars 2) (rooms-available 8) (rooms-booked 1) (services wifi tv air-conditioning))
  (facility (name "La piazza (BO)") (price 90) (city "Bologna") (stars 3) (rooms-available 2) (rooms-booked 5) (services wifi tv room-service air-conditioning pool pet))

  (facility (name "Movida (RM)") (price 35) (city "Rimini") (stars 2) (rooms-available 10) (rooms-booked 10) (services pool air-conditioning))
  (facility (name "Alla mattina (RM)") (price 70) (city "Rimini") (stars 3) (rooms-available 4) (rooms-booked 13) (services pool tv wifi air-conditioning))
  (facility (name "Nella notte (RM)") (price 50) (city "Rimini") (stars 2) (rooms-available 6) (rooms-booked 11) (services wifi tv air-conditioning))

  (facility (name "Il gelsomino (RA)") (price 140) (city "Ravenna") (stars 4) (rooms-available 12) (rooms-booked 15) (services wifi tv room-service air-conditioning spa))
  (facility (name "Baraonda (RA)") (price 20) (city "Ravenna") (stars 1) (rooms-available 11) (rooms-booked 16) (services air-conditioning))

  (facility (name "Bora (TS)") (price 85) (city "Trieste") (stars 3) (rooms-available 4) (rooms-booked 10) (services wifi tv room-service pool air-conditioning))
  (facility (name "Hotel D'Annunzio (TS)") (price 60) (city "Trieste") (stars 2) (rooms-available 7) (rooms-booked 3) (services wifi tv air-conditioning))

  (facility (name "Falco (AO)") (price 120) (city "Saint Vincent") (stars 4) (rooms-available 3) (rooms-booked 4) (services parking wifi tv spa room-service pool air-conditioning))
  (facility (name "L'azzardo (AO)") (price 100) (city "Saint Vincent") (stars 3) (rooms-available 5) (rooms-booked 7) (services parking wifi tv spa air-conditioning))
  (facility (name "Arietta (AO)") (price 90) (city "Saint Vincent") (stars 3) (rooms-available 4) (rooms-booked 5) (services parking wifi tv))
  (facility (name "Il giocatore (AO)") (price 130) (city "Saint Vincent") (stars 4) (rooms-available 6) (rooms-booked 10) (services parking wifi tv room-service pool air-conditioning))
  (facility (name "Una giocata al volo (AO)") (price 35) (city "Saint Vincent") (stars 1) (rooms-available 10) (rooms-booked 12) (services parking tv))

  (facility (name "La slavina (AO)") (price 60) (city "Aosta") (stars 2) (rooms-available 14) (rooms-booked 6) (services parking wifi tv))

  (facility (name "Con permesso (FE)") (price 60) (city "Ferrara") (stars 2) (rooms-available 2) (rooms-booked 1) (services parking wifi tv))
  (facility (name "Hotel Ripagrande (FE)") (price 90) (city "Ferrara") (stars 3) (rooms-available 1) (rooms-booked 12) (services parking wifi tv air-conditioning pet))

  (facility (name "Trentuno (TR)") (price 10) (city "Trento") (stars 1) (rooms-available 1) (rooms-booked 4) (services tv pet))
  (facility (name "Vento (TR)") (price 65) (city "Trento") (stars 3) (rooms-available 3) (rooms-booked 9) (services tv wifi parking pool))
  (facility (name "Baita tedesca (TR)") (price 80) (city "Trento") (stars 3) (rooms-available 4) (rooms-booked 2) (services tv spa wifi air-conditioning pet))
  (facility (name "Jodel (TR)") (price 40) (city "Trento") (stars 2) (rooms-available 7) (rooms-booked 1) (services tv spa wifi))
  (facility (name "Lo strudel (TR)") (price 40) (city "Trento") (stars 2) (rooms-available 1) (rooms-booked 5) (services tv wifi))
  
  (facility (name "San Francesco (PG)") (price 40) (city "Assisi") (stars 2) (rooms-available 6) (rooms-booked 2) (services tv wifi)) 
  (facility (name "Santa Chiara (PG)") (price 80) (city "Assisi") (stars 3) (rooms-available 20) (rooms-booked 12) (services tv pet wifi air-conditioning)) 
  (facility (name "Il colto (PG)") (price 60) (city "Assisi") (stars 2) (rooms-available 5) (rooms-booked 5) (services tv parking)) 
  (facility (name "La Porziuncola (PG)") (price 120) (city "Assisi") (stars 4) (rooms-available 9) (rooms-booked 4) (services tv pet air-conditioning pool spa wifi)) 
  (facility (name "Luxury place (PG)") (price 100) (city "Assisi") (stars 4) (rooms-available 10) (rooms-booked 3) (services tv pet air-conditioning pool spa wifi room-service)) 
  (facility (name "Ostello religioso (PG)") (price 40) (city "Assisi") (stars 2) (rooms-available 2) (rooms-booked 7) (services tv)) 

  (considered-hotels)
)

;Ho una confidenza in più sull'hotel da -0.2 a 0.2 in base alle stelle
(defrule GENERATE-FACILITIES::generate-facility-from-stars
  (iteration ?i)
  (attribute (name stars) (value ?stars) (certainty ?cf-stars) (iteration ?i))
  (facility (name ?name) (stars ?stars))
  =>
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-stars 0.2)) (iteration ?i)))
)

;Ho una confidenza in più sull'hotel da -0.4 a 0.4 in base alla città
(defrule GENERATE-FACILITIES::generate-facility-from-city 
  (iteration ?i)
  (attribute (name city) (value ?city) (certainty ?cf-city) (iteration ?i))
  (facility (name ?name) (city ?city))
  =>
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-city 0.4)) (iteration ?i)))
)

;Ho una confidenza in più sull'hotel da -0.4 a 0.4 in base al budget
(defrule GENERATE-FACILITIES::generate-facility-from-budget-upper-then-price
  (iteration ?i)
  (parameter-range (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(< ?price ?budget-per-day)))
  =>
  (bind ?lower-bound (- ?budget-per-day 60))
  (bind ?result (max (+ -0.4 (* (/ (- ?price ?lower-bound) (- ?budget-per-day ?lower-bound)) 0.8)) -0.4))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
      (iteration ?i)
    )
  )
)

;Ho una confidenza in più sull'hotel da -0.4 a 0.4 in base al budget
(defrule GENERATE-FACILITIES::generate-facility-from-budget-lower-then-price
  (iteration ?i)
  (parameter-range (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(>= ?price ?budget-per-day)))
  =>
  (bind ?upper-bound (+ ?budget-per-day 40))
  (bind ?result (max (+ -0.4 (* (/ (- ?price ?upper-bound) (- ?budget-per-day ?upper-bound)) 0.8)) -0.4))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
      (iteration ?i)
    )
  )
)

;Ho una confidenza in più sull'hotel da -0.1 a 0.1 in base ai servizi (più servizi ho in un hotel e più confidenza ho)
(defrule GENERATE-FACILITIES::generate-facility-from-services-present-in-facility ;Voglio o no il service, e l'hotel ce l'ha
  (iteration ?i)
  (attribute (name service) (value ?service) (certainty ?cf-service) (iteration ?i))
  (facility (name ?name) (services $? ?service $?))
  =>  
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-service 0.1)) (iteration ?i)))
)

(defrule GENERATE-FACILITIES::generate-facility-from-services-not-present-in-facility ;Voglio o no il service, e l'hotel NON ce l'ha
  (iteration ?i)
  (attribute (name service) (value ?service) (certainty ?cf-service) (iteration ?i))
  (facility (name ?name) (services $?services&:(not (member ?service ?services))))
  => 
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-service 0.1 -1)) (iteration ?i)))
)

;Ho una confidenza in più sull'hotel da -0.2 a 0.2 in base all'ocupazione della struttura
(defrule GENERATE-FACILITIES::generate-facility-from-availability
  (iteration ?i)
  ?attribute-facility <- (attribute (name facility) (value ?name) (iteration ?i)) 
  (facility (name ?name) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  ?considered <- (considered-hotels $?considered-hotels&:(not (member ?name $?considered-hotels)))
  =>
  (bind ?cf-contribution (+ (* (/ ?rooms-available (+ ?rooms-booked ?rooms-available)) 0.4) -0.2))
  (retract ?considered)
  (assert (considered-hotels $?considered-hotels ?name))
  (assert (attribute (name facility) (value ?name) (certainty ?cf-contribution) (iteration ?i)))
)

(defrule GENERATE-FACILITIES::reset-considered-hotels  (declare (salience -10))
  ?considered <- (considered-hotels $?)
  =>
  (retract ?considered)
  (assert (considered-hotels))
  (return)
)