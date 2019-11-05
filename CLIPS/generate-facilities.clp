(defmodule GENERATE-FACILITIES (import MAIN ?ALL))

(deftemplate GENERATE-FACILITIES::facility
  (slot name (type STRING))
  (slot city (type STRING))
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (multislot rooms (type INTEGER) (cardinality 2 2) (range 0 ?VARIABLE)) ;available - busy
  (multislot service (cardinality 0 ?VARIABLE))
)

(deffacts GENERATE-FACILITIES::facility-definition
  (facility (name "Vista Mare") (price 100) (city "Massa") (stars 4) (rooms 12 43) (service parking wifi pool tv spa room-service))
  (facility (name "Resort Miramare") (price 75) (city "Massa") (stars 3) (rooms 2 23) (service parking pet tv wifi))
  (facility (name "Ostello di Massa") (price 55) (city "Massa") (stars 2) (rooms 10 21) (service wifi tv))
  (facility (name "Hotel Cavour") (price 70) (city "Torino") (stars 3) (rooms 10 21) (service air-conditioning wifi pool tv room-service))
  (facility (name "Hotel Mazzini") (price 50) (city "Torino") (stars 2) (rooms 10 15) (service parking pool tv))
  (facility (name "Garda resort") (price 130) (city "Verona") (stars 4) (rooms 22 21) (service parking wifi air-conditioning tv spa room-service pet))
  (facility (name "Ostello della gioventu") (price 30) (city "Verona") (stars 1) (rooms 0 20) (service pet))
  (facility (name "Bella vista") (price 80) (city "Genova") (stars 3) (rooms 20 0) (service parking wifi tv pool pet))
  (facility (name "Al fresco") (price 30) (city "Imperia") (stars 1) (rooms 10 34) (service tv wifi))
  (facility (name "Al sole") (price 45) (city "Savona") (stars 2) (rooms 10 0) (service parking pet tv))
  (facility (name "Vento caldo") (price 110) (city "Savona") (stars 4) (rooms 10 21) (service wifi tv room-service pool air-conditioning))
)

(defrule GENERATE-FACILITIES::generate-facility-from-stars
  (attribute (name stars) (value ?stars) (certainty ?cf-stars))
  (facility (name ?name) (stars ?stars))
  =>
  (assert (attribute (name facility) (value ?name) (certainty ?cf-stars)))
)

; TODO trovare un modo per non mettere una salience. Scatta prima della fine del calcolo dell'attributo city
(defrule GENERATE-FACILITIES::generate-facility-from-city 
  (attribute (name city) (value ?city) (certainty ?cf-city))
  (facility (name ?name) (city ?city))
  =>
  (assert (attribute (name facility) (value ?name) (certainty ?cf-city)))
)

; TODO calcolare certezza FACILITY in base ai servizi e al budget
; (defrule GENERATE-FACILITIES::generate-facility-from-service
;   (facility (name ?name) (service $? ?service $?))
;   (or
;     (and
;       (attribute (name service) (value ?service) (certainty ?cf-service))
;       (bind ?cf-facility 0.1)
;     )
;     (and 
;       (not (attribute (name service) (value ?service)))
;       (bind ?cf-facility -0.1)
;     )
;   )
;   =>
;   (assert (attribute (name facility) (value ?name) (certainty ?cf-facility)))
; (attribute (name service) (value ?service) (certainty ?cf-service))
  ; (facility (name ?name) (service $? ?service $?))
  ; =>
  ; (assert (attribute (name facility) (value ?name) (certainty ?cf-service)))
;)

(defrule GENERATE-FACILITIES::generate-facility-from-budget-upper-then-price
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(< ?price ?budget-per-day)))
  =>
  (bind ?lower-bound (max (- ?budget-per-day 60) ?budget-min))
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
  (bind ?upper-bound (min (+ ?budget-per-day 40) ?budget-max))
  (bind ?result (max (+ -0.99 (* (/ (- ?price ?upper-bound) (- ?budget-per-day ?upper-bound)) 1.98)) -0.99))

  (assert 
    (attribute 
      (name facility) 
      (value ?name) 
      (certainty ?result)
    )
  )
)
; (certainty (- 0.99 (* 1.98 (/ (abs (- ?price ?budget-per-day)) 300))))
;(bind ?upper-bound (min (+ (?budget-per-day 40)) ?budget-max))
; Budget prefissato: 70. - 30 + 80
; -0.99 ... 0.99  ... -0.99 ... -0.99
; 0     ... 40    ... 150   ...

; (defrule GENERATE-FACILITIES::generate-city3
;   (attribute-pattern (name turism) (values $? ?turism&:(not (eq (type ?turism) INTEGER)) $?) (conjunction ?conj) (id ?id))
;   (attribute (name turism) (value ?turism) (certainty ?cf-turism) (type system))
;   (attribute (name region) (value ?region) (certainty ?cf-region) (type system))
;   (city (name ?city) (region ?region) (turism $? ?turism ?score $?))
;   =>
;   (bind ?cf-score (- (/ (* ?score 1.9) 5) 0.95))
;   (bind ?cf-city (min (- 1 (abs (- ?cf-score ?cf-turism))) ?cf-region))
;   (assert (pre-attribute (name city) (value ?city) (certainty ?cf-city) (conjunction ?conj) (id ?id)))
; )