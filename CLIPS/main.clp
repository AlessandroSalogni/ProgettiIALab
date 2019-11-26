(defmodule MAIN (import ITERATION-MANAGER ?ALL) (export ?ALL))

;;*****************
;;* INITIAL STATE *
;;*****************
(deftemplate MAIN::attribute
  (slot name)
  (slot value)
  (slot certainty (type FLOAT) (default 0.99) (range -0.99 0.99))
  (slot iteration)
)

(deftemplate MAIN::parameter-enumeration
  (slot name)
  (multislot values)
)

(deftemplate MAIN::parameter-range
  (slot name)
  (multislot range (cardinality 2 2) (type INTEGER))
)

(defrule MAIN::start (declare (salience 10000))
  (iteration ?i)
	=>
	(set-fact-duplication TRUE)
	(focus SET-USER-ATTRIBUTE EXPERTISE EXTRACT-SOLUTIONS PRINT-RESULTS ITERATION-MANAGER)
)

(defrule MAIN::combine-certainties-both-positive
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.0)) (iteration ?i))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(>= ?c2 0.0)) (iteration ?i))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (- (+ ?c1 ?c2) (* ?c1 ?c2))))
)

(defrule MAIN::combine-certainties-both-negative
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(< ?c1 0.0)) (iteration ?i))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(< ?c2 0.0)) (iteration ?i))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (+ (+ ?c1 ?c2) (* ?c1 ?c2))))
)

(defrule MAIN::combine-certainties-opposite
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.0)) (iteration ?i))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(< ?c2 0.0)) (iteration ?i))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (/ (+ ?c1 ?c2) (- 1 (min (abs ?c1) (abs ?c2))))))
)

(deffacts MAIN::define-parameter
  (parameter-enumeration (name region) (values piemonte liguria umbria marche toscana lombardia veneto valle-d'aosta trentino-alto-adige friuli-venezia-giulia emilia-romagna))
  (parameter-enumeration (name turism) (values sport religious enogastronomic cultural sea mountain lake termal naturalistic))
  (parameter-range (name stars) (range 1 4))
  (parameter-enumeration (name service) (values parking pool air-conditioning pet wifi tv spa room-service))
  (parameter-range (name number-people) (range 1 10))
  (parameter-range (name number-days) (range 1 30))
  (parameter-range (name budget-per-day) (range 10 300))
  (parameter-range (name number-places) (range 1 3))
  (parameter-enumeration (name group-detail) (values pet-service disability children))
)