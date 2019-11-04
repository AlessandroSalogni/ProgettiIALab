;;****************
;;* DESTINATIONS *
;;****************
(defmodule DESTINATIONS (import MAIN ?ALL))

(deftemplate DESTINATIONS::place
  (slot name (type STRING))
  (slot region)
  (multislot coordinates (type FLOAT) (cardinality 2 2))
  (multislot turism)
)

(deftemplate DESTINATIONS::facility
  (slot name (type STRING))
  (slot place (type STRING))
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (multislot rooms (type INTEGER) (cardinality 2 2) (range 0 ?VARIABLE)) ;available - busy
  (multislot service (cardinality 0 ?VARIABLE))
)

(deffacts DESTINATIONS::sites
  (place (name "Assisi") (region umbria) (coordinates 2.0 3.0) (turism mountain 2 cultural 5 enogastronomic 4 naturalistic 1 religious 5))
  (place (name "Milano") (region lombardia) (coordinates 2.0 3.0) (turism cultural 4 sport 1 enogastronomic 1 religious 2))
  (place (name "Desenzano del Garda") (region lombardia) (coordinates 2.0 3.0) (turism sport 2 lake 5 enogastronomic 1 naturalistic 3))
  (place (name "Como") (region lombardia) (coordinates 2.0 3.0) (turism mountain 2 cultural 1 sport 1 lake 4 enogastronomic 1 naturalistic 2 ))
  (place (name "Firenze") (region toscana) (coordinates 2.0 3.0) (turism cultural 5 enogastronomic 4 religious 3))
  (place (name "Siena") (region toscana) (coordinates 2.0 3.0) (turism cultural 4 termal 4 enogastronomic 4 religious 1))
  (place (name "Pisa") (region toscana) (coordinates 2.0 3.0) (turism sea 3 cultural 3 enogastronomic 3 religious 1))
  (place (name "Massa") (region toscana) (coordinates 2.0 3.0) (turism sea 4 sport 1 enogastronomic 3))
  (place (name "Savona") (region liguria) (coordinates 4.0 80.0) (turism sea 5 mountain 1 sport 2 enogastronomic 2 naturalistic 1))
  (place (name "Imperia") (region liguria) (coordinates 2.0 80.0) (turism sea 4 mountain 1 sport 2 enogastronomic 2 naturalistic 2))
  (place (name "Genova") (region liguria) (coordinates 6.0 80.0) (turism sea 4 mountain 1 sport 2 enogastronomic 3 naturalistic 1))
  (place (name "Celle Ligure") (region liguria) (coordinates 2.0 3.0) (turism sea 5 sport 2 enogastronomic 2 naturalistic 2))
  (place (name "Sestri Levante") (region liguria) (coordinates 2.0 3.0) (turism sea 5 sport 2 enogastronomic 2 naturalistic 2))
  (place (name "Torino") (region piemonte) (coordinates 6.0 80.0) (turism mountain 3 cultural 4 sport 1 enogastronomic 3 naturalistic 2 religious 2))
  (place (name "Biella") (region piemonte) (coordinates 6.0 80.0) (turism mountain 4 cultural 1 sport 2 enogastronomic 3 naturalistic 3 religious 5))
  (place (name "Verbania") (region piemonte) (coordinates 2.0 3.0) (turism mountain 5 sport 3 lake 5 termal 1 enogastronomic 3 naturalistic 4))
  (place (name "Cuneo") (region piemonte) (coordinates 2.0 3.0) (turism mountain 5 sport 2 termal 1 enogastronomic 3 naturalistic 4))
  (place (name "Verona") (region veneto) (coordinates 6.0 80.0) (turism mountain 1 cultural 4 sport 1 lake 5 enogastronomic 2 naturalistic 3))
  (place (name "Venezia") (region veneto) (coordinates 2.0 3.0) (turism sea 3 cultural 5 sport 1 enogastronomic 3 naturalistic 2 religious 2))
  (place (name "Padova") (region veneto) (coordinates 2.0 3.0) (turism mountain 1 cultural 5 enogastronomic 1 religious 4))
  (place (name "Gorizia") (region friuli-venezia-giulia) (coordinates 2.0 3.0) (turism sea 1 mountain 2 cultural 2 lake 1 enogastronomic 1 naturalistic 2))
  (place (name "Trieste") (region friuli-venezia-giulia) (coordinates 2.0 3.0) (turism sea 2 cultural 2 sport 2 enogastronomic 1 naturalistic 2))
  (place (name "Bolzano") (region trentino-alto-adige) (coordinates 2.0 3.0) (turism mountain 5 sport 4 lake 3 termal 2 enogastronomic 3 naturalistic 3))
  (place (name "Trento") (region trentino-alto-adige) (coordinates 2.0 3.0) (turism mountain 5 sport 4 lake 2 termal 2 enogastronomic 3 naturalistic 3))
  (place (name "Bologna") (region emilia-romagna) (coordinates 2.0 3.0) (turism cultural 3 enogastronomic 5 naturalistic 1))
  (place (name "Ravenna") (region emilia-romagna) (coordinates 2.0 3.0) (turism sea 5 cultural 1 sport 2 enogastronomic 4 naturalistic 2))
  (place (name "Ferrara") (region emilia-romagna) (coordinates 2.0 3.0) (turism cultural 2 lake 5 enogastronomic 3 naturalistic 2))
  (place (name "Aosta") (region valle-d'aosta) (coordinates 2.0 3.0) (turism mountain 5 cultural 1 sport 4 lake 1 termal 3 enogastronomic 2 naturalistic 4))
  (place (name "Saint Vincent") (region valle-d'aosta) (coordinates 2.0 3.0) (turism mountain 5 sport 1 termal 5 enogastronomic 1 naturalistic 4))

  (facility (name "Vista Mare") (price 100) (place "Massa") (stars 4) (rooms 12 43) (service parking wifi pool tv spa room-service))
  (facility (name "Resort Miramare") (price 75) (place "Massa") (stars 3) (rooms 2 23) (service parking pet tv wifi))
  (facility (name "Ostello di Massa") (price 55) (place "Massa") (stars 2) (rooms 10 21) (service wifi tv))
  (facility (name "Hotel Cavour") (price 70) (place "Torino") (stars 3) (rooms 10 21) (service air-conditioning wifi pool tv room-service))
  (facility (name "Hotel Mazzini") (price 50) (place "Torino") (stars 2) (rooms 10 15) (service parking pool tv))
  (facility (name "Garda resort") (price 130) (place "Verona") (stars 4) (rooms 22 21) (service parking wifi air-conditioning tv spa room-service pet))
  (facility (name "Ostello della gioventu") (price 30) (place "Verona") (stars 1) (rooms 0 20) (service pet))
  (facility (name "Bella vista") (price 80) (place "Genova") (stars 3) (rooms 20 0) (service parking wifi tv pool pet))
  (facility (name "Al fresco") (price 30) (place "Imperia") (stars 1) (rooms 10 34) (service tv wifi))
  (facility (name "Al sole") (price 45) (place "Savona") (stars 2) (rooms 10 0) (service parking pet tv))
  (facility (name "Vento caldo") (price 110) (place "Savona") (stars 4) (rooms 10 21) (service wifi tv room-service pool air-conditioning))
)

(defrule DESTINATIONS:generate-city-from-unspecified-turism
  (parameter (name turism) (values $? ?turism $?))
  (or
    (and
      (attribute (name turism) (value ?turism) (certainty ?cf-turism))
      (place (name ?city) (turism $? ?turism ?score $?))
    )
    (and
      (not (attribute (name turism) (value ?turism)))
      (place (name ?city) (turism $? ?turism ?score $?))
      (bind ?cf-turism 0) 
    )
    (and
      (attribute (name turism) (value ?turism) (certainty ?cf-turism))
      (place (name ?city) (turism $?turisms&:(not (member ?turism ?turisms))))
      (bind ?score 0) 
    )
    (and
      (not (attribute (name turism) (value ?turism)))
      (place (name ?city) (turism $?turisms&:(not (member ?turism ?turisms))))
      (bind ?cf-turism 0) 
      (bind ?score 0) 
    )
  )
  =>
  (bind ?cf-score (- (/ (* ?score 1.98) 5) 0.99))
  (assert (attribute (name city) (value ?city) (certainty (* ?cf-turism ?cf-score))))
)

(defrule DESTINATIONS::generate-city-from-region
  (attribute (name region) (value ?region) (certainty ?cf-region))
  (place (name ?city) (region ?region))
  =>
  (assert (attribute (name city) (value ?city) (certainty ?cf-region)))
)

(defrule DESTINATIONS::generate-hotel-from-stars
  (attribute (name stars) (value ?stars) (certainty ?cf-stars))
  (facility (name ?name) (stars ?stars))
  =>
  (assert (attribute (name hotel) (value ?name) (certainty ?cf-stars)))
)

;TODO trovare un modo per non mettere una salience. Scatta prima della fine del calcolo dell'attributo city
; (defrule DESTINATIONS::generate-hotel-from-city (declare (salience -10)) 
;   (attribute (name city) (value ?city) (certainty ?cf-city))
;   (facility (name ?name) (place ?city))
;   =>
;   (assert (attribute (name hotel) (value ?name) (certainty ?cf-city)))
; )

; TODO calcolare certezza hotel in base ai servizi e al budget
; (defrule DESTINATIONS::generate-hotel-from-service
;   (facility (name ?name) (service $? ?service $?))
;   (or
;     (and
;       (attribute (name service) (value ?service) (certainty ?cf-service))
;       (bind ?cf-hotel 0.1)
;     )
;     (and 
;       (not (attribute (name service) (value ?service)))
;       (bind ?cf-hotel -0.1)
;     )
;   )
;   =>
;   (assert (attribute (name hotel) (value ?name) (certainty ?cf-hotel)))
; (attribute (name service) (value ?service) (certainty ?cf-service))
  ; (facility (name ?name) (service $? ?service $?))
  ; =>
  ; (assert (attribute (name hotel) (value ?name) (certainty ?cf-service)))
)

(defrule DESTINATIONS::generate-hotel-from-min-to-budget
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(< ?price ?budget-per-day)))
  =>
  (bind ?lower-bound (max (- ?budget-per-day 60) ?budget-min))
  (bind ?result (max (+ -0.99 (* (/ (- ?price ?lower-bound) (- ?budget-per-day ?lower-bound)) 1.98)) -0.99))

  (assert 
    (attribute 
      (name hotel) 
      (value ?name) 
      (certainty ?result)
    )
  )
)

(defrule DESTINATIONS::generate-hotel-from-budget-to-max
  (parameter (name budget-per-day) (range ?budget-min ?budget-max))
  (user-attribute (name budget-per-day) (values ?budget-per-day))
  (facility (name ?name) (price ?price&:(>= ?price ?budget-per-day)))
  =>
  (bind ?upper-bound (min (+ ?budget-per-day 40) ?budget-max))
  (bind ?result (max (+ -0.99 (* (/ (- ?price ?upper-bound) (- ?budget-per-day ?upper-bound)) 1.98)) -0.99))

  (assert 
    (attribute 
      (name hotel) 
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

; (defrule DESTINATIONS::generate-city3
;   (attribute-pattern (name turism) (values $? ?turism&:(not (eq (type ?turism) INTEGER)) $?) (conjunction ?conj) (id ?id))
;   (attribute (name turism) (value ?turism) (certainty ?cf-turism) (type system))
;   (attribute (name region) (value ?region) (certainty ?cf-region) (type system))
;   (place (name ?city) (region ?region) (turism $? ?turism ?score $?))
;   =>
;   (bind ?cf-score (- (/ (* ?score 1.9) 5) 0.95))
;   (bind ?cf-place (min (- 1 (abs (- ?cf-score ?cf-turism))) ?cf-region))
;   (assert (pre-attribute (name city) (value ?city) (certainty ?cf-place) (conjunction ?conj) (id ?id)))
; )