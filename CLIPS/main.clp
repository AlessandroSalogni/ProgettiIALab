(defmodule MAIN (export ?ALL))

;;****************
;;* DEFFUNCTIONS *
;;****************
(deffunction MAIN::ask-question (?question ?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) then (bind ?answer (lowcase ?answer))))
   ?answer
)

;;*****************
;;* INITIAL STATE *
;;*****************
(deftemplate MAIN::attribute
  (slot name)
  (slot value)
  (slot certainty (type FLOAT) (default 0.99) (range -0.99 0.99))
  (slot type (allowed-symbols user system) (default system))
)

(deftemplate MAIN::attribute-pattern
  (slot name)
  (multislot values (cardinality 1 2))
  (slot conjunction (allowed-symbols and or not none))
  (slot id (default (gensym*)))
)

(defrule MAIN::start
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE)
	(focus SET-PARAMETER EXPERTISE DESTINATIONS PRINT-RESULTS)
)

(defrule MAIN::from-user-to-system-attribute
  (declare (salience 100) (auto-focus TRUE))
  ?attr <- (attribute (type user))
  =>
  (duplicate ?attr (type system))
)

(defrule MAIN::combine-certainties-both-positive
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.0)) (type system))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(>= ?c2 0.0)) (type system))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (- (+ ?c1 ?c2) (* ?c1 ?c2))))
)

(defrule MAIN::combine-certainties-both-negative
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(< ?c1 0.0)) (type system))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(< ?c2 0.0)) (type system))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (+ (+ ?c1 ?c2) (* ?c1 ?c2))))
)

(defrule MAIN::combine-certainties-opposite
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(>= ?c1 0.0)) (type system))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(< ?c2 0.0)) (type system))
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
