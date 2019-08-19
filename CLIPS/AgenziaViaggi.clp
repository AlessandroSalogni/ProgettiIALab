(defmodule MAIN (export ?ALL))
(defmodule DESTINATIONS)
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
(defrule MAIN::start
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE)
	(focus SET-PARAMETER DESTINATIONS PRINT-RESULTS)
)

;;******************
;;* REQUESTS RULES *
;;******************
(defmodule SET-PARAMETER (import MAIN ?ALL) (export ?ALL))

(deftemplate SET-PARAMETER::request
  (multislot attributes (cardinality 1 ?VARIABLE))
  (slot request (type STRING))
  (multislot valid-answers)
  (slot already-asked (default FALSE))
)

(defrule SET-PARAMETER::decide-first-search-parameter
  ?search-parameter <- (first-search-parameter not-set)
  (request
    (attributes not-set)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (first-search-parameter (ask-question ?request ?valid-answers)))
  (assert (second-search-parameter not-set))
)

(defrule SET-PARAMETER::decide-second-search-parameter
  ?first-search-parameter <- (first-search-parameter ?first-parameter&~not-set)
  ?second-search-parameter <- (second-search-parameter not-set)
  (request
    (attributes ?first-parameter not-set)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?second-search-parameter)
  (assert (second-search-parameter (ask-question ?request ?valid-answers)))
)

(defrule SET-PARAMETER::request-parameter
  ?first-search-parameter <- (first-search-parameter ?first-parameter&~not-set)
  ?second-search-parameter <- (second-search-parameter  ?second-parameter&~not-set)
  (request
    (attributes ?first-parameter ?second-parameter)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?second-search-parameter)
  (assert (second-search-parameter (ask-question ?request ?valid-answers)))
)

(deffacts SET-PARAMETER::define-requests
  (first-search-parameter not-set)
  (request (attributes not-set) (request "Quele parametro di ricerca vuoi impostare? ") (valid-answers destinazione))
  (request (attributes destinazione not-set) (request "Quale parametro di ricerca per la destinazione vuoi impostare? ") (valid-answers regione))
  (request (attributes destinazione regione) (request "Che regione/i vuoi visitare? ") (valid-answers piemonte))
)

;;****************
;;* DESTINATIONS *
;;****************
(deftemplate DESTINATIONS::place
    (slot name (type STRING)) ;;stringa ???
    (slot region) ;;stringa ???
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
    (slot rooms (type INTEGER) (range 1 ?VARIABLE))
    (slot free-rooms (type INTEGER) (range 0 ?VARIABLE)) ;; Fino a rooms
)

(deffacts DESTINATIONS::sites
    (place (name "massa") (region piemonte) (coordinates 2.0 3.0) (sea_stars 2) (mountain_stars 4))
    ;;(site (name LaSpezia) (coordinates 2 3) (hotels Giggi Puppi Costa) (sea_stars 2) (mountain_stars 4))
    (facility (name "Puppi") (place massa) (stars 4))
)
