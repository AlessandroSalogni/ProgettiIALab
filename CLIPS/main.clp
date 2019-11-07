(defmodule MAIN (export ?ALL))

;;*****************
;;* INITIAL STATE *
;;*****************
(deftemplate MAIN::attribute
  (slot name)
  (slot value)
  (slot certainty (type FLOAT) (default 0.99) (range -0.99 0.99))
)

(deftemplate MAIN::user-attribute
  (slot name)
  (multislot values)
  (slot type (allowed-symbols mandatory optional profile inferred) (default optional))
)

(deftemplate MAIN::parameter
  (slot name)
  (multislot values)
  (multislot range (cardinality 2 2) (type INTEGER))
)

(defrule MAIN::start
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE)
	(focus SET-USER-ATTRIBUTE EXPERTISE GENERATE-SOLUTIONS PRINT-RESULTS)
)

(defrule MAIN::combine-certainties-both-positive
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.0)))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(>= ?c2 0.0)))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (- (+ ?c1 ?c2) (* ?c1 ?c2))))
)

(defrule MAIN::combine-certainties-both-negative
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(< ?c1 0.0)))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(< ?c2 0.0)))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (+ (+ ?c1 ?c2) (* ?c1 ?c2))))
)

(defrule MAIN::combine-certainties-opposite
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.0)))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(< ?c2 0.0)))
  ; (test (not (and (eq ?c1 1.0) (eq ?c2 -1.0))))
  ; (test (or (< ?c1 0.5) (> ?c2 -0.5)))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (/ (+ ?c1 ?c2) (- 1 (min (abs ?c1) (abs ?c2))))))
)

; (defrule MAIN::combine-certainties-opposite-contradictory
;   (declare (salience 100) (auto-focus TRUE))
;   ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.5)))
;   ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(<= ?c2 -0.5)))
;   =>
;   (focus SET-USER-ATTRIBUTE)
; )

(deffacts MAIN::define-parameter
  (parameter (name region) (values piemonte liguria umbria marche toscana lombardia veneto valle-d'aosta trentino-alto-adige friuli-venezia-giulia emilia-romagna))
  (parameter (name turism) (values sport religious enogastronomic cultural sea mountain lake termal naturalistic))
  (parameter (name stars) (range 1 4))
  (parameter (name service) (values parking pool air-conditioning pet wifi tv spa room-service))
  (parameter (name number-people) (range 1 10))
  (parameter (name number-days) (range 1 30))
  (parameter (name budget-per-day) (range 10 300))
)