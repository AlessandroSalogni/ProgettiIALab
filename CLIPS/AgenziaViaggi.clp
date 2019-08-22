(defmodule MAIN (export ?ALL))
(defmodule DESTINATIONS (import MAIN ?ALL))
(defmodule PRINT-RESULTS)

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
  (slot certainty (type FLOAT) (default 1.0) (range -1.0 1.0))
  (slot inferred (default FALSE))
)

(defrule MAIN::start
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE)
	(focus SET-PARAMETER EXPERTISE DESTINATIONS PRINT-RESULTS)
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
  (test (and (neq ?c1 1.0) (neq ?c2 -1.0)))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (/ (+ ?c1 ?c2) (- 1 (min (abs ?c1) (abs ?c2))))))
)

(defrule MAIN::combine-certainties-max-opposite
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (attribute (name ?name) (value ?val) (certainty ?c1&:(eq ?c1 1.0)))
  ?attr2 <- (attribute (name ?name) (value ?val) (certainty ?c2&:(eq ?c2 -1.0)))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty 1.0)) ; perchè con -0.9 e 1 viene 1 l'altra regola
)

;;*****************
;;* SET-PARAMETER *
;;*****************
(defmodule SET-PARAMETER (import MAIN ?ALL))

(deftemplate SET-PARAMETER::request
  (slot search-parameter)
  (slot terminal-request (default FALSE))
  (slot request (type STRING))
  (multislot valid-answers)
)

(defrule SET-PARAMETER::leave-focus
  ?search-parameter <- (search-parameter end)
  ?history <- (search-parameter-history start)
  =>
  (retract ?search-parameter)
  (assert (search-parameter start))
  (retract ?history)
  (assert (search-parameter-history))
  (return)
)

(defrule SET-PARAMETER::leave-request
  ?search-parameter <- (search-parameter end)
  ?history <- (search-parameter-history $?history-parameter ?prev-parameter ?current-parameter)
  =>
  (retract ?search-parameter)
  (assert (search-parameter ?prev-parameter))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter))
)

(defrule SET-PARAMETER::start-request
  ?search-parameter <- (search-parameter start)
  ?history <- (search-parameter-history)
  (request
    (search-parameter start)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter (ask-question ?request ?valid-answers)))
  (retract ?history)
  (assert (search-parameter-history start))
)

(defrule SET-PARAMETER::non-terminal-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (request
    (search-parameter ?parameter)
    (terminal-request FALSE)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter (ask-question ?request ?valid-answers)))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
)

(defrule SET-PARAMETER::terminal-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (request
    (search-parameter ?parameter)
    (terminal-request TRUE)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (assert (attribute
            (name ?parameter)
            (value (ask-question ?request ?valid-answers))
          )
  )
)

(deffacts SET-PARAMETER::define-requests
  (search-parameter start)
  (search-parameter-history)
  (request (search-parameter start) (request "Which search parameter would you like to set? ") (valid-answers destination budget facility end))
  (request (search-parameter destination) (request "Which search parameter of destination would you like to set? ") (valid-answers region end))
  (request (search-parameter region) (terminal-request TRUE) (request "Which region would you like to visit? ") (valid-answers piemonte liguria toscana lombardia veneto))
  (request (search-parameter budget) (terminal-request TRUE) (request "How much budget? ") (valid-answers 100 200 300 400 500 600 700 800 900 1000)) ; mettere un range?
  (request (search-parameter facility) (request "Which search parameter of facility would you like to set? ") (valid-answers stars comfort end))
  (request (search-parameter stars) (terminal-request TRUE) (request "How many stars would you like? ") (valid-answers 1 2 3 4))
  (request (search-parameter comfort) (terminal-request TRUE) (request "Which comfort would you like to have? ") (valid-answers parking pool air-conditioning pet-allowed wifi tv gym))
)

;;****************
;;*  EXPERTISE   *
;;****************
(defmodule EXPERTISE (import MAIN ?ALL))

(deftemplate EXPERTISE::inference
  (slot attribute)
  (multislot expertise)
)

(deffacts EXPERTISE::expertise-knowledge
  (inference (attribute liguria) (expertise exp-turism [ sea 0.8 mountain 0.3 enogastronomic 0.5 lake -0.9 termal -0.5
    sport 0.5 naturalistic 0.6 cultural 0.0 religious 0.0 ]))
  (inference (attribute piemonte) (expertise exp-turism [ sea -1.0 mountain 0.9 enogastronomic 0.7 lake 0.5 termal 0.2
    sport 0.0 naturalistic 0.0 cultural 0.0 religious 0.4 ]))
)

(defrule EXPERTISE::expertise-rule
  (attribute (name ?user-attribute) (value ?name) (inferred FALSE))
  (inference (attribute ?name) (expertise $?prev ?attribute [ $?values ] $?next))
  =>
  (assert (new-attributes ?attribute $?values))
)

(defrule EXPERTISE::create-attribute
  ?fact <- (new-attributes ?attribute ?value ?cf $?next)
  =>
  (retract ?fact)
  (bind ?new-attributes ?attribute $?next)
  (assert (new-attributes ?new-attributes))
  (assert (attribute (name ?attribute) (value ?value) (certainty ?cf) (inferred TRUE)))
)

(defrule EXPERTISE::remove-empty-new-attributes
  ?fact <- (new-attributes ?attribute)
  =>
  (retract ?fact)
)

; (defrule EXPERTISE::turism-mountain-to-region
;   (attribute (name turism) (value mountain)) ;(certainty ?cf&:(>= ?cf 0.5)))
;   ;(bind ?factor (- 1 ?cf))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty 0.9)));- 0.9 ?factor))))
;   (assert (attribute (name region) (value liguria) (certainty -0.2)));+ -0.2 ?factor))))
; )
;
; (defrule EXPERTISE::turism-sea-to-region
;   (attribute (name turism) (value sea))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty -0.9)))
;   (assert (attribute (name region) (value liguria) (certainty 0.8)))
; )
;
; (defrule EXPERTISE::turism-enogastronomic-to-region
;   (attribute (name turism) (value enogastronomic))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty 0.4)))
;   (assert (attribute (name region) (value liguria) (certainty 0.2)))
; )
;
; (defrule EXPERTISE::turism-sport-to-region
;   (attribute (name turism) (value mountain))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty 0.0)))
;   (assert (attribute (name region) (value liguria) (certainty 0.0)))
; )
;
; (defrule EXPERTISE::turism-lake-to-region
;   (attribute (name turism) (value lake))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty 0.5)))
;   (assert (attribute (name region) (value liguria) (certainty -0.8)))
; )
;
; (defrule EXPERTISE::turism-termal-to-region
;   (attribute (name turism) (value termal))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty 0.6)))
;   (assert (attribute (name region) (value liguria) (certainty -0.6)))
; )
;
; (defrule EXPERTISE::turism-naturalistic-to-region
;   (attribute (name turism) (value naturalistic))
;   =>
;   (assert (attribute (name region) (value piemonte) (certainty 0.7)))
;   (assert (attribute (name region) (value liguria) (certainty 0.6)))
; )


;** RULES BASED ON STARS
(defrule EXPERTISE::region-facility-stars-4
  (attribute (name stars) (value 4))
  =>
  (assert (attribute (name comfort) (value wifi) (certainty 1.0)))
  (assert (attribute (name comfort) (value parking) (certainty 1.0)))
  (assert (attribute (name comfort) (value pet-allowed) (certainty 0.8)))
  (assert (attribute (name comfort) (value tv) (certainty 1.0)))
  (assert (attribute (name comfort) (value gym) (certainty 1.0)))
  (assert (attribute (name comfort) (value air-conditioning) (certainty 1.0)))
  (assert (attribute (name comfort) (value pool) (certainty 1.0)))
)

(defrule EXPERTISE::region-facility-stars-3
  (attribute (name stars) (value 3))
  =>
  (assert (attribute (name comfort) (value wifi) (certainty 1.0)))
  (assert (attribute (name comfort) (value parking) (certainty 1.0)))
  (assert (attribute (name comfort) (value pet-allowed) (certainty 0.4)))
  (assert (attribute (name comfort) (value tv) (certainty 1.0)))
  (assert (attribute (name comfort) (value gym) (certainty 0.4)))
  (assert (attribute (name comfort) (value air-conditioning) (certainty 0.8)))
  (assert (attribute (name comfort) (value pool) (certainty 0.8)))
)

(defrule EXPERTISE::region-facility-stars-2
  (attribute (name stars) (value 2))
  =>
  (assert (attribute (name comfort) (value wifi) (certainty 0.6)))
  (assert (attribute (name comfort) (value parking) (certainty 0.6)))
  (assert (attribute (name comfort) (value pet-allowed) (certainty 0.2)))
  (assert (attribute (name comfort) (value tv) (certainty 0.6)))
  (assert (attribute (name comfort) (value gym) (certainty 0.2)))
  (assert (attribute (name comfort) (value air-conditioning) (certainty 0.4)))
  (assert (attribute (name comfort) (value pool) (certainty 0.2)))
)

(defrule EXPERTISE::region-facility-stars-1
  (attribute (name stars) (value 1))
  =>
  (assert (attribute (name comfort) (value wifi) (certainty 0.4)))
  (assert (attribute (name comfort) (value parking) (certainty 0.2)))
  (assert (attribute (name comfort) (value pet-allowed) (certainty 0.0)))
  (assert (attribute (name comfort) (value tv) (certainty 0.4)))
  (assert (attribute (name comfort) (value gym) (certainty 0.0)))
  (assert (attribute (name comfort) (value air-conditioning) (certainty 0.2)))
  (assert (attribute (name comfort) (value pool) (certainty 0.0)))
)

;;****************
;;* DESTINATIONS *
;;****************
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
  (place (name "Massa") (region toscana) (coordinates 2.0 3.0) (turism sea 4))
  (place (name "Savona") (region liguria) (coordinates 4.0 80.0) (turism sea 5 naturalistic 0))
  (place (name "Imperia") (region liguria) (coordinates 2.0 80.0) (turism sea 4 mountain 1))
  (place (name "Genova") (region liguria) (coordinates 6.0 80.0) (turism sea 4))
  (place (name "Torino") (region piemonte) (coordinates 6.0 80.0) (turism mountain 3 religious 2 cultural 5))
  (place (name "Biella") (region piemonte) (coordinates 6.0 80.0) (turism mountain 4 religious 5 naturalistic 3 lake 2 enogastronomic 3))
  (place (name "Verona") (region veneto) (coordinates 6.0 80.0) (turism mountain 3 cultural 5 lake 5 enogastronomic 4))

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

(defrule DESTINATIONS:generate-solution2
  (attribute (name turism) (value ?type) (certainty ?cf-turism))
  (attribute (name region) (value ?region) (certainty ?cf-region))
  (place (name ?city) (region ?region) (turism $?type-turism&:(not (member ?type ?type-turism))))
  =>
  (bind ?cf-place (min (- 1 (abs (- -1 ?cf-turism))) ?cf-region))
  (assert (attribute (name city) (value ?city) (certainty ?cf-place)))
)

(defrule DESTINATIONS:generate-solution
  (attribute (name turism) (value ?type) (certainty ?cf-turism))
  (attribute (name region) (value ?region) (certainty ?cf-region))
  (place (name ?city) (region ?region) (turism $? ?type ?score $?))
  =>
  (bind ?cf-score (- (/ (* ?score 2) 5) 1))
  (bind ?cf-place (min (- 1 (abs (- ?cf-score ?cf-turism))) ?cf-region))
  (assert (attribute (name city) (value ?city) (certainty ?cf-place)))
)
