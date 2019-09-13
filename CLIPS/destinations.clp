;;****************
;;* DESTINATIONS *
;;****************
(defmodule DESTINATIONS (import MAIN ?ALL))

(deftemplate DESTINATIONS::place
  (slot name (type STRING)) ;;stringa ???
  (slot region) ;;stringa ??? elencare regioni ??
  (multislot coordinates (type FLOAT) (cardinality 2 2))
  (multislot turism)
)

(deftemplate DESTINATIONS::facility
  (slot name (type STRING))
  (slot place (type STRING)) ;; Type place
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (slot parking (default FALSE))
  (slot air-conditioning (default FALSE))
  (slot pet-allowed (default FALSE))
  (slot pool (default FALSE))
  (slot gym (default FALSE))
  (slot tv (default FALSE))
  (slot wifi (default FALSE))
  (multislot rooms (type INTEGER) (cardinality 2 2) (range 0 ?VARIABLE)) ;available - busy
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

  (facility
    (name "Vista Mare") (price 100) (place "Massa") (stars 4) (rooms 12 43)
    (parking TRUE) (pool TRUE) (tv TRUE))
  (facility
    (name "Resort Miramare") (price 75) (place "Massa") (stars 3) (rooms 2 23)
    (parking TRUE) (pet-allowed TRUE) (gym TRUE))
  (facility
    (name "Ostello di Massa") (price 55) (place "Massa") (stars 2) (rooms 10 21))
  (facility
    (name "Hotel Cavour") (price 70) (place "Torino") (stars 3) (rooms 10 21)
    (parking TRUE) (air-conditioning TRUE) (wifi TRUE))
  (facility
    (name "Hotel Mazzini") (price 50) (place "Torino") (stars 2) (rooms 10 15)
    (parking TRUE) (pool TRUE) (tv TRUE))
  (facility
    (name "Garda resort") (price 130) (place "Verona") (stars 4) (rooms 22 21)
    (parking TRUE) (air-conditioning TRUE) (tv TRUE))
  (facility
    (name "Ostello della gioventu") (price 30) (place "Verona") (stars 1) (rooms 0 20)
    (pet-allowed TRUE) (air-conditioning TRUE))
  (facility
    (name "Bella vista") (price 80) (place "Genova") (stars 3) (rooms 20 0)
    (wifi TRUE) (pool TRUE) (tv TRUE))
  (facility
    (name "Al fresco") (price 30) (place "Imperia") (stars 1) (rooms 10 34)
    (air-conditioning TRUE) (gym TRUE))
  (facility
    (name "Al sole") (price 45) (place "Savona") (stars 2) (rooms 10 0)
    (parking TRUE) (pet-allowed TRUE) (tv TRUE))
  (facility
    (name "Vento caldo") (price 110) (place "Savona") (stars 4) (rooms 10 21)
    (parking TRUE) (pool TRUE) (gym TRUE))
)

; (defrule DESTINATIONS:generate-city2
;   (attribute (name turism) (value ?type) (certainty ?cf-turism))
;   (attribute (name region) (value ?region) (certainty ?cf-region))
;   (place (name ?city) (region ?region) (turism $?type-turism&:(not (member ?type ?type-turism))))
;   =>
;   (bind ?cf-place (min (- 1 (abs (- -0.9 ?cf-turism))) ?cf-region))
;   (assert (attribute (name city) (value ?city) (certainty ?cf-place)))
; )

(deftemplate DESTINATIONS::pre-attribute
  (slot name)
  (slot value)
  (slot certainty (type FLOAT) (default 0.99) (range -0.99 0.99))
  (slot conjunction (allowed-values and or not))
  (slot id)
)
;
; (defrule DESTINATIONS::generate-city
;   (attribute (name turism) (value ?type) (certainty ?cf-turism) (type system))
;   (attribute (name region) (value ?region) (certainty ?cf-region) (type system))
;   (place (name ?city) (region ?region) (turism $? ?type ?score $?))
;   =>
;   (bind ?cf-score (- (/ (* ?score 1.9) 5) 0.95))
;   (bind ?cf-place (min (- 1 (abs (- ?cf-score ?cf-turism))) ?cf-region))
;   (assert (attribute (name city) (value ?city) (certainty ?cf-place)))
; )

(defrule DESTINATIONS::generate-city3
  (attribute-pattern (name turism) (values $? ?turism&:(not (eq (type ?turism) INTEGER)) $?) (conjunction ?conj) (id ?id))
  (attribute (name turism) (value ?turism) (certainty ?cf-turism) (type system))
  (attribute (name region) (value ?region) (certainty ?cf-region) (type system))
  (place (name ?city) (region ?region) (turism $? ?turism ?score $?))
  =>
  (bind ?cf-score (- (/ (* ?score 1.9) 5) 0.95))
  (bind ?cf-place (min (- 1 (abs (- ?cf-score ?cf-turism))) ?cf-region))
  (assert (pre-attribute (name city) (value ?city) (certainty ?cf-place) (conjunction ?conj) (id ?id)))
)

(defrule DESTINATIONS::combine-pre-or-attribute
  ?attr1 <- (pre-attribute (name ?name) (value ?value) (certainty ?c1) (conjunction or))
  ?attr2 <- (pre-attribute (name ?name) (value ?value) (certainty ?c2) (conjunction or))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (max ?c1 ?c2)))
)

(defrule DESTINATIONS::complex-pattern
  (declare (salience -10))
  ?attr <- (pre-attribute (id ?old-id))
  (attribute-pattern (values $? ?old-id $?) (conjunction ?conj) (id ?new-id))
  =>
  (modify ?attr (id ?new-id) (conjunction ?conj))
)
