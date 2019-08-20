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
   ?answer)

;;*****************
;;* INITIAL STATE *
;;*****************
(deftemplate MAIN::attribute
  (slot name)
  (slot value)
  (slot certainty (default 100.0))
)

(defrule MAIN::start
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE)
	(focus SET-PARAMETER DESTINATIONS PRINT-RESULTS)
)

;;******************
;;* REQUESTS RULES *
;;******************
(defmodule SET-PARAMETER (import MAIN ?ALL))

(deftemplate SET-PARAMETER::request
  (multislot search-parameters (cardinality 3 3)) ;; current, prev, next = TRUE/FALSE
  (slot request (type STRING))
  (multislot valid-answers)
  (slot already-asked (default FALSE))
)

(defrule SET-PARAMETER::leave-focus
  ?search-parameter <- (search-parameter end start)
  =>
  (retract ?search-parameter)
  (assert (search-parameter start not-set))
  (return)
)

(defrule SET-PARAMETER::leave-subrequest
  ?search-parameter <- (search-parameter end ?prev-parameter&~start)
  =>
  (retract ?search-parameter)
  (assert (search-parameter ?prev-parameter))
)

(defrule SET-PARAMETER::start-request
  ?search-parameter <- (search-parameter start not-set)
  (request
    (search-parameters start $?other)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter (ask-question ?request ?valid-answers) start))
)

(defrule SET-PARAMETER::non-terminal-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end ?prev-parameter)
  (request
    (search-parameters ?parameter ?prev-parameter TRUE)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter (ask-question ?request ?valid-answers) ?parameter))
)

(defrule SET-PARAMETER::terminal-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end ?prev-parameter)
  (request
    (search-parameters ?parameter ?prev-parameter FALSE)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  ; (retract ?search-parameter)
  ; (assert (search-parameter ?parameter))
  (assert (attribute
            (name ?parameter)
            (value (ask-question ?request ?valid-answers))
          )
  )
)

(deffacts SET-PARAMETER::define-requests
  (search-parameter start not-set)
  (request (search-parameters start not-set TRUE) (request "Quele parametro di ricerca vuoi impostare? ") (valid-answers destination end))
  (request (search-parameters destination start TRUE) (request "Quale parametro di ricerca per la destinazione vuoi impostare? ") (valid-answers region end))
  (request (search-parameters region destination FALSE) (request "Che regione vuoi visitare? ") (valid-answers piemonte liguria toscana lombardia end))
)

;;****************
;;* DESTINATIONS *
;;****************
(deftemplate DESTINATIONS::place
  (slot name (type STRING)) ;;stringa ???
  (slot region) ;;stringa ??? elencare regioni ??
  (multislot coordinates (type FLOAT) (cardinality 2 2))
  (slot sea_stars (type INTEGER) (default 0) (range 0 5))
  (slot mountain_stars (type INTEGER) (default 0) (range 0 5))
  (slot lake_stars (type INTEGER) (default 0) (range 0 5))
  (slot naturalistic_stars (type INTEGER) (default 0) (range 0 5))
  (slot termal_stars (type INTEGER) (default 0) (range 0 5))
  (slot cultural_stars (type INTEGER) (default 0) (range 0 5))
  (slot religious_stars (type INTEGER) (default 0) (range 0 5))
  (slot enogastronomic_stars (type INTEGER) (default 0) (range 0 5))
  (slot sport_stars (type INTEGER) (default 0) (range 0 5))
)

(deftemplate DESTINATIONS::facility
  (slot name (type STRING))
  (slot place (type STRING)) ;; Type place
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (multislot rooms (type INTEGER) (cardinality 2 2) (range 0 ?VARIABLE)) ;available - busy
)

; (deftemplate DESTINATIONS::visit
;   (slot people (type INTEGER) (range 1 ?VARIABLE))
; )

(deffacts DESTINATIONS::sites
  (place (name "Massa") (region toscana) (coordinates 2.0 3.0) (sea_stars 4) (mountain_stars 0))
  (place (name "Savona") (region liguria) (coordinates 4.0 80.0) (sea_stars 5) (mountain_stars 0))
  (place (name "Imperia") (region liguria) (coordinates 2.0 80.0) (sea_stars 4) (mountain_stars 1))
  (place (name "Genova") (region liguria) (coordinates 6.0 80.0) (sea_stars 4) (mountain_stars 0))
  (place (name "Torino") (region piemonte) (coordinates 6.0 80.0) (mountain_stars 3) (religious_stars 2) (cultural_stars 5))
  (place (name "Verona") (region veneto) (coordinates 6.0 80.0) (mountain_stars 3) (cultural_stars 5) (lake_stars 5) (enogastronomic_stars 4))

  (facility (name "Vista Mare") (price 100) (place "Massa") (stars 4) (rooms 12 43))
  (facility (name "Resort Miramare") (price 75) (place "Massa") (stars 3) (rooms 2 23))
  (facility (name "Ostello di Massa") (price 55) (place "Massa") (stars 2) (rooms 10 21))
  (facility (name "Hotel Cavour") (price 70) (place "Torino") (stars 3) (rooms 10 21))
  (facility (name "Hotel Mazzini") (price 50) (place "Torino") (stars 2) (rooms 10 15))
  (facility (name "Garda resort") (price 130) (place "Verona") (stars 4) (rooms 22 21))
  (facility (name "Ostello della gioventu") (price 30) (place "Verona") (stars 1) (rooms 0 20))
  (facility (name "Bella vista") (price 80) (place "Genova") (stars 3) (rooms 20 0))
  (facility (name "Al fresco") (price 30) (place "Imperia") (stars 1) (rooms 10 34))
  (facility (name "Al sole") (price 45) (place "Savona") (stars 2) (rooms 10 0))
  (facility (name "Vento caldo") (price 110) (place "Savona") (stars 4) (rooms 10 21))
)

(defrule DESTINATIONS::by-place
  (attribute (name region) (value ?region) (certainty ?certainty))
  (place (name ?name) (region ?region))
  =>
  (printout ?name)
)
