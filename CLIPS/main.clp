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
  (slot type (allowed-symbols mandatory optional profile) (default optional))
)

(deftemplate MAIN::parameter
  (slot name)
  (multislot values)
  (multislot range (cardinality 2 2) (type INTEGER))
)

(deffacts MAIN::parameter
  (parameter (name region) (values piemonte liguria umbria marche toscana lombardia veneto valle-d'aosta trentino-alto-adige friuli-venezia-giulia emilia-romagna))
  (parameter (name turism) (values sport religious enogastronomic cultural sea mountain lake termal naturalistic))
  (parameter (name stars) (range 1 4))
  (parameter (name service) (values parking pool air-conditioning pet wifi tv gym room-service))
  (parameter (name number-people) (range 1 10))
  (parameter (name number-days) (range 1 30))
  (parameter (name budget-per-day) (range 10 300))
)

(defrule MAIN::start
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE)
	(focus MANDATORY-QUESTIONS USER-PROFILE SET-PARAMETER EXPERTISE DESTINATIONS PRINT-RESULTS)
)

; (defrule MAIN::from-user-to-system-attribute
;   (declare (salience 100) (auto-focus TRUE))
;   (user-attribute
;     (name ?name)
;     (values $? ?value $?)
;     (type optional)
;   )
;   =>
;   (assert (attribute (name ?name) (value ?value)))
; )

(defrule MAIN::combine-user-attribute-value ; TODO controllare quando i val hanno alcuni valori in comune? magari 2 regole per l'inserimento dell'utente
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?val1) (type ?type))
  ?attr2 <- (user-attribute (name ?name) (values $?val2) (type ?type))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (values $?val1 $?val2))
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
  (test (not (and (eq ?c1 1.0) (eq ?c2 -1.0))))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (/ (+ ?c1 ?c2) (- 1 (min (abs ?c1) (abs ?c2))))))
)

;Non viene mai 1 in teoria
; (defrule MAIN::combine-certainties-max-opposite
;   (declare (salience 100) (auto-focus TRUE))
;   ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(eq ?c1 1.0)) (type system))
;   ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(eq ?c2 -1.0)) (type system))
;   =>
;   (retract ?attr1)
;   (modify ?attr2 (certainty 1.0) (inferred FALSE)) ; perchè con -0.9 e 1 viene 1 l'altra regola
; )
