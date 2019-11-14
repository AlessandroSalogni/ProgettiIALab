(defmodule GENERATE-FACILITIES (import MAIN ?ALL) (import USER-INTERACTION ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL)) 

(deftemplate GENERATE-FACILITIES::facility
  (slot name (type STRING))
  (slot city (type STRING))
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (multislot rooms (type INTEGER) (range 0 ?VARIABLE)) ;available
  (multislot services (cardinality 0 ?VARIABLE))
)

(deffacts GENERATE-FACILITIES::facility-definition
  (facility (name "Vista Mare (MS)") (price 100) (city "Massa") (stars 4) (rooms 12) (services parking wifi pool tv spa room-service))
  (facility (name "Resort Miramare (MS)") (price 75) (city "Massa") (stars 3) (rooms 2) (services parking pet tv wifi))
  (facility (name "Ostello di Massa (MS)") (price 50) (city "Massa") (stars 2) (rooms 10) (services wifi tv))

  (facility (name "Hotel Cavour (TO)") (price 70) (city "Torino") (stars 3) (rooms 10) (services air-conditioning wifi pool tv room-service))
  (facility (name "Hotel Mazzini (TO)") (price 50) (city "Torino") (stars 2) (rooms 5) (services parking pool tv))
  (facility (name "Hotel Mucrone (TO)") (price 55) (city "Torino") (stars 2) (rooms 12) (services wifi tv))
  (facility (name "Avogadro Hostel (TO)") (price 15) (city "Torino") (stars 1) (rooms 3) (services parking))

  (facility (name "Garda resort (VR)") (price 130) (city "Verona") (stars 4) (rooms 22) (services parking wifi air-conditioning tv spa room-service pet))
  (facility (name "Ostello della gioventu (VR)") (price 30) (city "Verona") (stars 1) (rooms 0) (services pet))

  (facility (name "Bella vista (GE)") (price 80) (city "Genova") (stars 3) (rooms 20) (services parking wifi tv pool pet))

  (facility (name "Al fresco (IM)") (price 30) (city "Imperia") (stars 1) (rooms 10) (services tv wifi))

  (facility (name "Al sole (SV)") (price 45) (city "Savona") (stars 2) (rooms 10) (services parking pet tv))

  (facility (name "La rocca (BO)") (price 80) (city "Bologna") (stars 3) (rooms 21) (services wifi tv room-service air-conditioning))

  (facility (name "Movida (RM)") (price 35) (city "Rimini") (stars 2) (rooms 10) (services pool air-conditioning))

  (facility (name "Il gelsomino (RA)") (price 140) (city "Ravenna") (stars 4) (rooms 12) (services wifi tv room-service air-conditioning spa))
  (facility (name "Baraonda (RA)") (price 20) (city "Ravenna") (stars 1) (rooms 11) (services air-conditioning))

  (facility (name "Bora (TS)") (price 85) (city "Trieste") (stars 3) (rooms 4) (services wifi tv room-service pool air-conditioning))

  (facility (name "Falco (AO)") (price 120) (city "Saint Vincent") (stars 4) (rooms 3) (services parking wifi tv spa room-service pool air-conditioning))
  (facility (name "L'azzardo (AO)") (price 100) (city "Saint Vincent") (stars 3) (rooms 5) (services parking wifi tv spa air-conditioning))
  (facility (name "Arietta (AO)") (price 90) (city "Saint Vincent") (stars 3) (rooms 4) (services parking wifi tv))
  (facility (name "Il giocatore (AO)") (price 130) (city "Saint Vincent") (stars 4) (rooms 6) (services parking wifi tv room-service pool air-conditioning))

  (facility (name "Con permesso (FE)") (price 60) (city "Ferrara") (stars 2) (rooms 2) (services parking wifi tv))

  (facility (name "Trentuno (TR)") (price 10) (city "Trento") (stars 1) (rooms 1) (services tv pet))
  (facility (name "Vento (TR)") (price 65) (city "Trento") (stars 3) (rooms 3) (services tv wifi parking pool))
  (facility (name "Baita tedesca (TR)") (price 80) (city "Trento") (stars 3) (rooms 4) (services tv spa wifi air-conditioning pet))
)

;Ho una confidenza in più sull'hotel da -0.4 a 0.4 in base alle stelle
(defrule GENERATE-FACILITIES::generate-facility-from-stars
  (iteration ?i)
  (attribute (name stars) (value ?stars) (certainty ?cf-stars) (iteration ?i))
  (facility (name ?name) (stars ?stars))
  =>
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-stars 0.4)) (iteration ?i)))
)

;Ho una confidenza in più sull'hotel da -0.6 a 0.6 in base alla città
(defrule GENERATE-FACILITIES::generate-facility-from-city 
  (iteration ?i)
  (attribute (name city) (value ?city) (certainty ?cf-city) (iteration ?i))
  (facility (name ?name) (city ?city))
  =>
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-city 0.6)) (iteration ?i)))
)

;Ho una confidenza in più sull'hotel da -0.6 a 0.6 in base al budget
(defrule GENERATE-FACILITIES::generate-facility-from-budget-upper-then-price
  (iteration ?i)
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(< ?price ?budget-per-day)))
  =>
  (bind ?lower-bound (- ?budget-per-day 60))
  (bind ?result (max (+ -0.6 (* (/ (- ?price ?lower-bound) (- ?budget-per-day ?lower-bound)) 1.2)) -0.6))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
      (iteration ?i)
    )
  )
)

;Ho una confidenza in più sull'hotel da -0.6 a 0.6 in base al budget
(defrule GENERATE-FACILITIES::generate-facility-from-budget-lower-then-price
  (iteration ?i)
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(>= ?price ?budget-per-day)))
  =>
  (bind ?upper-bound (+ ?budget-per-day 40))
  (bind ?result (max (+ -0.6 (* (/ (- ?price ?upper-bound) (- ?budget-per-day ?upper-bound)) 1.2)) -0.6))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
      (iteration ?i)
    )
  )
)

;Ho una confidenza in più sull'hotel da -0.2 a 0.2 in base ai servizi (più servizi ho in un hotel e più confidenza ho)
(defrule GENERATE-FACILITIES::generate-facility-from-services-present-in-facility ;Voglio o no il service, e l'hotel ce l'ha
  (iteration ?i)
  (attribute (name service) (value ?service) (certainty ?cf-service) (iteration ?i))
  (facility (name ?name) (services $? ?service $?))
  =>  
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-service 0.2)) (iteration ?i)))
)

(defrule GENERATE-FACILITIES::generate-facility-from-services-not-present-in-facility ;Voglio o no il service, e l'hotel NON ce l'ha
  (iteration ?i)
  (attribute (name service) (value ?service) (certainty ?cf-service) (iteration ?i))
  (facility (name ?name) (services $?services&:(not (member ?service ?services))))
  => 
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-service 0.2 -1)) (iteration ?i)))
)

;l'utente non ha detto niente sul service
;TODO il service è presente nell'hotel (è un di piu, lo apprezzo con 0.1?)
; (defrule GENERATE-FACILITIES::generate-facility-from-services-3
;   (facility (name ?name) (services $? $?service $?))
;   (not (attribute (name service) (value $?service)))
;   =>
;   (assert (attribute (name facility) (value ?name) (certainty 0.1)))
; )