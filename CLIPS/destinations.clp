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
  (place (name "Assisi") (region umbria) (coordinates 2.0 3.0) (turism sea 0 mountain 2 cultural 5 sport 0 lake 0 termal 0 enogastronomic 4 naturalistic 1 religious 5))
  (place (name "Milano") (region lombardia) (coordinates 2.0 3.0) (turism sea 0 mountain 0 cultural 4 sport 1 lake 0 termal 0 enogastronomic 1 naturalistic 0 religious 2))
  (place (name "Desenzano del Garda") (region lombardia) (coordinates 2.0 3.0) (turism sea 0 mountain 0 cultural 0 sport 2 lake 5 termal 0 enogastronomic 1 naturalistic 3 religious 0))
  (place (name "Como") (region lombardia) (coordinates 2.0 3.0) (turism sea 0 mountain 2 cultural 1 sport 1 lake 4 termal 0 enogastronomic 1 naturalistic 2 religious 0))
  (place (name "Firenze") (region toscana) (coordinates 2.0 3.0) (turism sea 0 mountain 0 cultural 5 sport 0 lake 0 termal 0 enogastronomic 4 naturalistic 0 religious 3))
  (place (name "Siena") (region toscana) (coordinates 2.0 3.0) (turism sea 0 mountain 0 cultural 4 sport 0 lake 0 termal 4 enogastronomic 4 naturalistic 0 religious 1))
  (place (name "Pisa") (region toscana) (coordinates 2.0 3.0) (turism sea 3 mountain 0 cultural 3 sport 0 lake 0 termal 0 enogastronomic 3 naturalistic 0 religious 1))
  (place (name "Massa") (region toscana) (coordinates 2.0 3.0) (turism sea 4 mountain 0 cultural 0 sport 1 lake 0 termal 0 enogastronomic 3 naturalistic 0 religious 0))
  (place (name "Savona") (region liguria) (coordinates 4.0 80.0) (turism sea 5 mountain 1 cultural 0 sport 2 lake 0 termal 0 enogastronomic 2 naturalistic 1 religious 0))
  (place (name "Imperia") (region liguria) (coordinates 2.0 80.0) (turism sea 4 mountain 1 cultural 0 sport 2 lake 0 termal 0 enogastronomic 2 naturalistic 2 religious 0))
  (place (name "Genova") (region liguria) (coordinates 6.0 80.0) (turism sea 4 mountain 1 cultural 0 sport 2 lake 0 termal 0 enogastronomic 3 naturalistic 1 religious 0))
  (place (name "Celle Ligure") (region liguria) (coordinates 2.0 3.0) (turism sea 5 mountain 0 cultural 0 sport 2 lake 0 termal 0 enogastronomic 2 naturalistic 2 religious 0))
  (place (name "Sestri Levante") (region liguria) (coordinates 2.0 3.0) (turism sea 5 mountain 0 cultural 0 sport 2 lake 0 termal 0 enogastronomic 2 naturalistic 2 religious 0))
  (place (name "Torino") (region piemonte) (coordinates 6.0 80.0) (turism sea 0 mountain 3 cultural 4 sport 1 lake 0 termal 0 enogastronomic 3 naturalistic 2 religious 2))
  (place (name "Biella") (region piemonte) (coordinates 6.0 80.0) (turism sea 0 mountain 4 cultural 1 sport 2 lake 0 termal 0 enogastronomic 3 naturalistic 3 religious 5))
  (place (name "Verbania") (region piemonte) (coordinates 2.0 3.0) (turism sea 0 mountain 5 cultural 0 sport 3 lake 5 termal 1 enogastronomic 3 naturalistic 4 religious 0))
  (place (name "Cuneo") (region piemonte) (coordinates 2.0 3.0) (turism sea 0 mountain 5 cultural 0 sport 2 lake 0 termal 1 enogastronomic 3 naturalistic 4 religious 0))
  (place (name "Verona") (region veneto) (coordinates 6.0 80.0) (turism sea 0 mountain 1 cultural 4 sport 1 lake 5 termal 0 enogastronomic 2 naturalistic 3 religious 0))
  (place (name "Venezia") (region veneto) (coordinates 2.0 3.0) (turism sea 3 mountain 0 cultural 5 sport 1 lake 0 termal 0 enogastronomic 3 naturalistic 2 religious 2))
  (place (name "Padova") (region veneto) (coordinates 2.0 3.0) (turism sea 0 mountain 1 cultural 5 sport 0 lake 0 termal 0 enogastronomic 1 naturalistic 0 religious 4))
  (place (name "Gorizia") (region friuli-venezia-giulia) (coordinates 2.0 3.0) (turism sea 1 mountain 2 cultural 2 sport 0 lake 1 termal 0 enogastronomic 1 naturalistic 2 religious 0))
  (place (name "Trieste") (region friuli-venezia-giulia) (coordinates 2.0 3.0) (turism sea 2 mountain 0 cultural 2 sport 2 lake 0 termal 0 enogastronomic 1 naturalistic 2 religious 0))
  (place (name "Bolzano") (region trentino-alto-adige) (coordinates 2.0 3.0) (turism sea 0 mountain 5 cultural 0 sport 4 lake 3 termal 2 enogastronomic 3 naturalistic 3 religious 0))
  (place (name "Trento") (region trentino-alto-adige) (coordinates 2.0 3.0) (turism sea 0 mountain 5 cultural 0 sport 4 lake 2 termal 2 enogastronomic 3 naturalistic 3 religious 0))
  (place (name "Bologna") (region emilia-romagna) (coordinates 2.0 3.0) (turism sea 0 mountain 0 cultural 3 sport 0 lake 0 termal 0 enogastronomic 5 naturalistic 1 religious 0))
  (place (name "Ravenna") (region emilia-romagna) (coordinates 2.0 3.0) (turism sea 5 mountain 0 cultural 1 sport 2 lake 0 termal 0 enogastronomic 4 naturalistic 2 religious 0))
  (place (name "Ferrara") (region emilia-romagna) (coordinates 2.0 3.0) (turism sea 0 mountain 0 cultural 2 sport 0 lake 5 termal 0 enogastronomic 3 naturalistic 2 religious 0))
  (place (name "Aosta") (region valle-d'aosta) (coordinates 2.0 3.0) (turism sea 0 mountain 5 cultural 1 sport 4 lake 1 termal 3 enogastronomic 2 naturalistic 4 religious 0))
  (place (name "Saint Vincent") (region valle-d'aosta) (coordinates 2.0 3.0) (turism sea 0 mountain 5 cultural 0 sport 1 lake 0 termal 5 enogastronomic 1 naturalistic 4 religious 0))

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
    (
      (not (attribute (name turism) (value ?turism)))
      (place (name ?city) (turism $? ?turism ?score $?))
      (bind ?cf-turism 0) 
    )
    (
      (attribute (name turism) (value ?turism) (certainty ?cf-turism))
      (not (place (name ?city) (turism $? ?turism $?)))
      (bind ?score 0) 
    )
    (
      (not (attribute (name turism) (value ?turism)))
      (not (place (name ?city) (turism $? ?turism $?)))
      (bind ?cf-turism 0) 
      (bind ?score 0) 
    )
  )
  =>
  ; (bind ?cf-place (min (- 1 (abs (- -0.9 ?cf-turism))) ?cf-region))
  ; (assert (attribute (name city) (value ?city) (certainty ?cf-place)))
)

(defrule DESTINATIONS::generate-city-from-region
  (attribute (name region) (value ?region) (certainty ?cf-region))
  (place (name ?city) (region ?region))
  =>
  (assert (attribute (name city) (value ?city) (certainty ?cf-region)))
)

(defrule DESTINATIONS::generate-city-from-turism
  (attribute (name turism) (value ?type) (certainty ?cf-turism))
  (place (name ?city) (turism $? ?type ?score $?))
  =>
  (bind ?cf-score (- (/ (* ?score 1.98) 5) 0.99))
  (assert (attribute (name city) (value ?city) (certainty (- 1 (abs (- ?cf-turism ?cf-score))))))
)

(defrule DESTINATIONS::generate-hotel-from-stars
  (attribute (name city) (value ?city) (certainty ?cf-city))
  (attribute (name stars) (value ?stars) (certainty ?cf-stars))
  (facility (name ?name) (place ?city) (stars ?stars))
  =>
  (assert (attribute (name hotel) (value ?name) (certainty (min ?cf-city ?cf-stars))))
)

; (defrule DESTINATIONS::generate-hotel-from-budget
;   (user-attribute (name budget-per-day) (value ?budget-per-day))
;   (attribute (name city) (value ?city) (certainty ?cf-city))
;   (facility (name ?name) (place ?city) (stars ?stars) (service $? ?service $?))
;   =>

; )

(defrule DESTINATIONS::generate-hotel-from-service
  (attribute (name city) (value ?city) (certainty ?cf-city))
  (attribute (name service) (value ?service) (certainty ?cf-service))
  (facility (name ?name) (place ?city) (service $? ?service $?))
  =>
  (assert (attribute (name hotel) (value ?name) (certainty (min ?cf-city ?cf-service))))
)

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
