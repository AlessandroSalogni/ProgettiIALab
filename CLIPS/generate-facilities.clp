(defmodule GENERATE-FACILITIES (import MAIN ?ALL)(export ?ALL))

(deftemplate GENERATE-FACILITIES::facility
  (slot name (type STRING))
  (slot city (type STRING))
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (multislot rooms (type INTEGER) (cardinality 2 2) (range 0 ?VARIABLE)) ;available - busy
  (multislot services (cardinality 0 ?VARIABLE))
)

(deffacts GENERATE-FACILITIES::facility-definition
  (facility (name "Vista Mare") (price 100) (city "Massa") (stars 4) (rooms 12 43) (services parking wifi pool tv spa room-service))
  (facility (name "Resort Miramare") (price 75) (city "Massa") (stars 3) (rooms 2 23) (services parking pet tv wifi))
  (facility (name "Ostello di Massa") (price 55) (city "Massa") (stars 2) (rooms 10 21) (services wifi tv))
  (facility (name "Hotel Cavour") (price 70) (city "Torino") (stars 3) (rooms 10 21) (services air-conditioning wifi pool tv room-service))
  (facility (name "Hotel Mazzini") (price 50) (city "Torino") (stars 2) (rooms 10 15) (services parking pool tv))
  (facility (name "Garda resort") (price 130) (city "Verona") (stars 4) (rooms 22 21) (services parking wifi air-conditioning tv spa room-service pet))
  (facility (name "Ostello della gioventu") (price 30) (city "Verona") (stars 1) (rooms 0 20) (services pet))
  (facility (name "Bella vista") (price 80) (city "Genova") (stars 3) (rooms 20 0) (services parking wifi tv pool pet))
  (facility (name "Al fresco") (price 30) (city "Imperia") (stars 1) (rooms 10 34) (services tv wifi))
  (facility (name "Al sole") (price 45) (city "Savona") (stars 2) (rooms 10 0) (services parking pet tv))
  (facility (name "Vento caldo") (price 110) (city "Savona") (stars 4) (rooms 10 21) (services wifi tv room-service pool air-conditioning))
)

(defrule GENERATE-FACILITIES::generate-facility-from-stars
  (attribute (name stars) (value ?stars) (certainty ?cf-stars))
  (facility (name ?name) (stars ?stars))
  =>
  (assert (attribute (name facility) (value ?name) (certainty ?cf-stars)))
)

(defrule GENERATE-FACILITIES::generate-facility-from-city 
  (attribute (name city) (value ?city) (certainty ?cf-city))
  (facility (name ?name) (city ?city))
  =>
  (assert (attribute (name facility) (value ?name) (certainty ?cf-city)))
)

(defrule GENERATE-FACILITIES::generate-facility-from-budget-upper-then-price
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(< ?price ?budget-per-day)))
  =>
  (bind ?lower-bound (- ?budget-per-day 60))
  (bind ?result (max (+ -0.99 (* (/ (- ?price ?lower-bound) (- ?budget-per-day ?lower-bound)) 1.98)) -0.99))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
    )
  )
)

(defrule GENERATE-FACILITIES::generate-facility-from-budget-lower-then-price
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(>= ?price ?budget-per-day)))
  =>
  (bind ?upper-bound (+ ?budget-per-day 40))
  (bind ?result (max (+ -0.99 (* (/ (- ?price ?upper-bound) (- ?budget-per-day ?upper-bound)) 1.98)) -0.99))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
    )
  )
)

(defrule GENERATE-FACILITIES::generate-facility-from-services
  (or
    (and ;Voglio o no il service, e l'hotel ce l'ha
      (attribute (name service) (value ?service) (certainty ?cf-service))
      (facility (name ?name) (services $? ?service $?))
      (bind ?sign 1)
    )
    (and ;Voglio o no il service, e l'hotel NON ce l'ha
      (attribute (name service) (value ?service) (certainty ?cf-service))
      (facility (name ?name) (services $?services&:(not (member ?service ?services))))
      (bind ?sign -1)
    )
  )
  =>
  (assert (attribute (name facility) (value ?name) (certainty (* ?cf-service 0.4 ?sign))))
)

;l'utente non ha detto niente sul service
;TODO il service è presente nell'hotel (è un di piu, lo apprezzo con 0.1?)
; (defrule GENERATE-FACILITIES::generate-facility-from-services-3
;   (facility (name ?name) (services $? $?service $?))
;   (not (attribute (name service) (value $?service)))
;   =>
;   (assert (attribute (name facility) (value ?name) (certainty 0.1)))
; )