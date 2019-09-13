(defmodule DESTINATIONS (import MAIN ?ALL))
(defmodule PRINT-RESULTS)


;;****************
;;* USER-PROFILE *
;;****************
(defmodule USER-PROFILE (import MAIN ?ALL))

(deftemplate profile
  (slot name (type STRING))
  (slot birth-year (type INTEGER))
  (slot live-region)
  (multislot comfort)
  (multislot turism)
)

(deffacts USER-PROFILE::profile-definition
  (profile (name "Riccardo Perotti") (birth-year 1996) (live-region piemonte) (comfort wifi )  )
)

;;*****************
;;* SET-PARAMETER *
;;*****************
(defmodule SET-PARAMETER (import MAIN ?ALL) (export ?ALL))

(deftemplate SET-PARAMETER::menu-request
  (slot search-parameter)
  (slot request (type STRING))
  (multislot valid-answers)
)

(deftemplate SET-PARAMETER::preference-request
  (slot search-parameter)
  (slot request (type STRING))
  (multislot valid-answers)
)

(deftemplate answer
  (multislot user-answer)
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

(defrule SET-PARAMETER::start-menu-request
  ?search-parameter <- (search-parameter start)
  ?history <- (search-parameter-history)
  (menu-request
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

(defrule SET-PARAMETER::menu-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (menu-request
    (search-parameter ?parameter)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter (ask-question ?request ?valid-answers)))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
)

(defrule SET-PARAMETER::preference-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (preference-request
    (search-parameter ?parameter)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (printout t ?request)
  (bind ?answer (explode$ (readline)))
  (assert (answer
            (user-answer ?answer)
            (valid-answers ?valid-answers)
          )
  )
  (focus CHECK-USER-ANSWER)
)

(deffacts SET-PARAMETER::define-requests
  (search-parameter start)
  (search-parameter-history)
  (menu-request (search-parameter start) (request "Which search parameter would you like to set? ") (valid-answers destination budget facility end))
  (menu-request (search-parameter destination) (request "Which search parameter of destination would you like to set? ") (valid-answers region turism end))
  (preference-request (search-parameter turism) (request "Which turism do you prefer? ") (valid-answers sport religious enogastronomic cultural sea mountain lake termal naturalistic))
  (preference-request (search-parameter region) (request "Which region would you like to visit? ") (valid-answers piemonte liguria umbria marche toscana lombardia veneto valle-d'aosta trentino-alto-adige friuli-venezia-giulia emilia-romagna))
  (preference-request (search-parameter budget) (request "How much budget? ") (valid-answers 100 200 300 400 500 600 700 800 900 1000)) ; mettere un range?
  (menu-request (search-parameter facility) (request "Which search parameter of facility would you like to set? ") (valid-answers stars comfort end))
  (preference-request (search-parameter stars) (request "How many stars would you like? ") (valid-answers 1 2 3 4))
  (preference-request (search-parameter comfort) (request "Which comfort would you like to have? ") (valid-answers parking pool air-conditioning pet-allowed wifi tv gym))
)

;;************************
;;*  CHECK-USER-ANSWER   *
;;************************
(defmodule CHECK-USER-ANSWER (import SET-PARAMETER ?ALL))

(defrule CHECK-USER-ANSWER::no-pattern-match
  (declare (salience -10))
  ?search-parameter <- (search-parameter ?parameter)
  ?answer <- (answer)
  =>
  (retract ?answer)
  (retract ?search-parameter)
  (assert (search-parameter ?parameter))
)

(defrule CHECK-USER-ANSWER::single-word-pattern
  ?search-parameter <- (search-parameter ?parameter)
  ?history <- (search-parameter-history $?history-parameter)
  ?answer <- (answer
    (valid-answers $?valid-answers)
    (user-answer ?word&:(member ?word ?valid-answers))
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (retract ?answer)
  (assert (attribute
            (name ?parameter)
            (value ?word)
            (type user)
          )
  )
)

(defrule CHECK-USER-ANSWER::single-or-pattern
  ?search-parameter <- (search-parameter ?parameter)
  ?history <- (search-parameter-history $?history-parameter)
  ?answer <- (answer
    (valid-answers $?valid-answers)
    (user-answer ?first-word&:(member ?first-word ?valid-answers) or ?second-word&~?first-word&:(member ?second-word ?valid-answers))
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (retract ?answer)
  (assert
    (attribute
      (name ?parameter)
      (value ?first-word)
      (certainty 0.80)
      (type user)
    )
  )
  (assert
    (attribute
      (name ?parameter)
      (value ?second-word)
      (certainty 0.80)
      (type user)
    )
  )
  (bind ?id (gensym*))
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?first-word ?second-word)
      (conjunction or)
      (id ?id)
    )
  )
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?id)
      (conjunction none)
    )
  )
)

(defrule CHECK-USER-ANSWER::double-or-pattern
  ?search-parameter <- (search-parameter ?parameter)
  ?history <- (search-parameter-history $?history-parameter)
  ?answer <- (answer
    (valid-answers $?valid-answers)
    (user-answer ?first-word&:(member ?first-word ?valid-answers) or ?second-word&~?first-word&:(member ?second-word ?valid-answers)
      or ?third-word&~?first-word&~?second-word&:(member ?third-word ?valid-answers))
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (retract ?answer)
  (assert
    (attribute
      (name ?parameter)
      (value ?first-word)
      (certainty 0.65)
      (type user)
    )
  )
  (assert
    (attribute
      (name ?parameter)
      (value ?second-word)
      (certainty 0.65)
      (type user)
    )
  )
  (assert
    (attribute
      (name ?parameter)
      (value ?third-word)
      (certainty 0.65)
      (type user)
    )
  )
  (bind ?id1 (gensym*))
  (bind ?id2 (gensym*))
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?first-word ?second-word)
      (conjunction or)
      (id ?id1)
    )
  )
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?id1 ?third-word)
      (conjunction or)
      (id ?id2)
    )
  )
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?id2)
      (conjunction none)
    )
  )
)

(defrule CHECK-USER-ANSWER::single-and-pattern
  ?search-parameter <- (search-parameter ?parameter)
  ?history <- (search-parameter-history $?history-parameter)
  ?answer <- (answer
    (valid-answers $?valid-answers)
    (user-answer ?first-word&:(member ?first-word ?valid-answers) and ?second-word&:(member ?second-word ?valid-answers))
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (retract ?answer)
  (assert
    (attribute
      (name ?parameter)
      (value ?first-word)
      (type user)
    )
  )
  (assert
    (attribute
      (name ?parameter)
      (value ?second-word)
      (type user)
    )
  )
  (bind ?id (gensym*))
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?first-word ?second-word)
      (conjunction and)
      (id ?id)
    )
  )
  (assert
    (attribute-pattern
      (name ?parameter)
      (values ?id)
      (conjunction none)
    )
  )
)

;;****************
;;*  EXPERTISE   *
;;****************
(defmodule EXPERTISE (import MAIN ?ALL))

(deftemplate EXPERTISE::inference
  (slot attribute)
  (slot value)
  (multislot expertise)
)

(deftemplate EXPERTISE::expertise-attribute
  (slot name)
  (slot value)
  (slot certainty (type FLOAT) (default 0.99) (range -0.99 0.99))
  (multislot created-by (cardinality 2 2))
)

(deffacts EXPERTISE::expertise-knowledge
  (inference (attribute region) (value liguria) (expertise turism [ sea 0.8 mountain 0.3 enogastronomic 0.5 lake -0.9 termal -0.5
    sport 0.5 naturalistic 0.6 religious 0.0 cultural 0.0 ] region [ piemonte 0.1 toscana 0.6 lombardia 0.0 valle-d'aosta -0.6
    trentino-alto-adige -0.8 veneto 0.2 emilia-romagna 0.2 umbria -0.7 marche 0.3 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute region) (value piemonte) (expertise turism [ sea -0.9 mountain 0.9 enogastronomic 0.7 lake 0.5 termal 0.2
    sport 0.0 naturalistic 0.0 religious 0.4 cultural 0.4 ] region [ liguria 0.1 toscana -0.5 lombardia 0.5 valle-d'aosta 0.7
    trentino-alto-adige 0.4 veneto 0.0 emilia-romagna 0.0 umbria -0.1 marche -0.8 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value sea) (expertise region [ piemonte -0.8 liguria 0.8 toscana 0.7 lombardia -0.8 valle-d'aosta -0.9
    trentino-alto-adige -0.9 veneto 0.7 emilia-romagna 0.9 umbria -0.6 marche 0.4 friuli-venezia-giulia 0.3 ]))
  (inference (attribute turism) (value mountain) (expertise region [ piemonte 0.7 liguria -0.2 toscana -0.3 lombardia 0.4 valle-d'aosta 0.9
    trentino-alto-adige 0.9 veneto 0.0 emilia-romagna -0.9 umbria 0.0 marche -0.6 friuli-venezia-giulia 0.2 ] ))
  (inference (attribute turism) (value enogastronomic) (expertise region [ piemonte 0.5 liguria 0.5 toscana 0.7 lombardia 0.0 valle-d'aosta 0.2
    trentino-alto-adige 0.2 veneto 0.4 emilia-romagna 0.8 umbria 0.5 marche 0.0 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value sport) (expertise region [ piemonte 0.0 liguria 0.2 toscana 0.0 lombardia -0.2 valle-d'aosta 0.6
    trentino-alto-adige 0.6 veneto 0.0 emilia-romagna 0.3 umbria 0.0 marche 0.2 friuli-venezia-giulia 0.3 ] ))
  (inference (attribute turism) (value lake) (expertise region [ piemonte 0.5 liguria -0.8 toscana -0.7 lombardia 0.8 valle-d'aosta -0.2
    trentino-alto-adige 0.5 veneto 0.2 emilia-romagna 0.0 umbria 0.3 marche -0.6 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value naturalistic) (expertise region [ piemonte 0.5 liguria 0.4 toscana 0.2 lombardia 0.0 valle-d'aosta 0.7
    trentino-alto-adige 0.8 veneto -0.3 emilia-romagna -0.6 umbria 0.0 marche -0.1 friuli-venezia-giulia 0.3 ] ))
  (inference (attribute turism) (value cultural) (expertise region [ piemonte 0.4 liguria -0.4 toscana 0.9 lombardia 0.5 valle-d'aosta 0.0
    trentino-alto-adige -0.6 veneto 0.6 emilia-romagna 0.0 umbria 0.8 marche 0.0 friuli-venezia-giulia 0.3 ] ))
  (inference (attribute turism) (value termal) (expertise region [ piemonte 0.0 liguria -0.5 toscana 0.6 lombardia 0.5 valle-d'aosta 0.2
    trentino-alto-adige 0.7 veneto 0.0 emilia-romagna -0.4 umbria 0.0 marche 0.0 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value religious) (expertise region [ piemonte 0.5 liguria -0.3 toscana 0.4 lombardia 0.2 valle-d'aosta 0.0
    trentino-alto-adige -0.5 veneto 0.0 emilia-romagna 0.0 umbria 0.8 marche 0.6 friuli-venezia-giulia 0.0 ] ))
)

(defrule EXPERTISE::expertise-rule
  (attribute (name ?user-attribute) (value ?value) (type user))
  (inference (attribute ?user-attribute) (value ?value) (expertise $?prev ?attribute [ $?values&:(not (member ] ?values)) ] $?next))
  =>
  (assert (new-attributes ?user-attribute ?value ?attribute $?values))
)

(defrule EXPERTISE::create-expertise-attribute
  ?fact <- (new-attributes ?from-attribute ?from-value ?attribute ?value ?cf $?next)
  =>
  (retract ?fact)
  (assert (new-attributes ?from-attribute ?from-value ?attribute $?next))
  (assert (expertise-attribute (name ?attribute) (value ?value) (certainty ?cf) (created-by ?from-attribute ?from-value)))
)

(defrule EXPERTISE::remove-empty-new-attributes
  ?fact <- (new-attributes ?from-attribute ?from-value ?attribute)
  =>
  (retract ?fact)
)

(defrule EXPERTISE::pattern-or-from-expertise-to-system
  (attribute-pattern (name ?from-attribute) (values ?from-value1 ?from-value2) (conjunction or) (id ?id))
  ?attr1 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf1) (created-by ?from-attribute ?from-value1))
  ?attr2 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf2) (created-by ?from-attribute ?from-value2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (max ?cf1 ?cf2)) (created-by ?from-attribute ?id))
)

(defrule EXPERTISE::pattern-and-turism-from-expertise-to-system
  (attribute-pattern (name turism) (values ?from-value1 ?from-value2) (conjunction and) (id ?id))
  ?attr1 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf1) (created-by turism ?from-value1))
  ?attr2 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf2) (created-by turism ?from-value2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (min ?cf1 ?cf2)) (created-by turism ?id))
  (assert (attribute (name different-region) (value 1))) ; TODO valutare certezza
)

(defrule EXPERTISE::pattern-none-from-expertise-to-system
  (attribute-pattern (name ?from-attribute) (values ?from-value) (conjunction none))
  ?attr <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf) (created-by ?from-attribute ?from-value))
  =>
  (retract ?attr)
  (assert (attribute (name ?name) (value ?value) (certainty ?cf)))
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
