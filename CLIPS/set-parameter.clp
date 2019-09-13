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
