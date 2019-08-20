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
  (request (search-parameter region) (terminal-request TRUE) (request "Which region would you like to visit? ") (valid-answers piemonte liguria toscana lombardia))
  (request (search-parameter budget) (terminal-request TRUE) (request "How much budget? ") (valid-answers 100 200 300 400 500 600 700 800 900 1000)) ; mettere un range?
  (request (search-parameter facility) (request "Which search parameter of facility would you like to set? ") (valid-answers stars comfort end))
  (request (search-parameter stars) (terminal-request TRUE) (request "How many stars would you like? ") (valid-answers 1 2 3 4))
  (request (search-parameter comfort) (terminal-request TRUE) (request "Which comfort would you like to have? ") (valid-answers parking pool air-conditioning pet-allowed wifi tv gym))
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
  (slot parking (default FALSE))
  (slot air-conditioning (default FALSE))
  (slot pet-allowed (default FALSE))
  (slot pool (default FALSE))
  (slot gym (default FALSE))
  (slot tv (default FALSE))
  (slot wifi (default FALSE))
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

(defrule DESTINATIONS::by-place
  (attribute (name region) (value ?region) (certainty ?certainty))
  (place (name ?place-name) (region ?region))
  (facility (place ?place-name) (name ?hotel-name))
  =>
  (format t "%-24s %-24s %n" ?hotel-name ?place-name)
)
