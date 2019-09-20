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
  )
  (parameter
    (name ?parameter)
    (values $?valid-answers)
  )
  =>
  (printout t ?request)
  (bind ?answer (explode$ (readline)))
  (assert
    (answer
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
  (preference-request (search-parameter turism) (request "Which turism do you prefer? "))
  (preference-request (search-parameter region) (request "Which region would you like to visit? "))
  (preference-request (search-parameter budget) (request "How much budget? "))
  (menu-request (search-parameter facility) (request "Which search parameter of facility would you like to set? ") (valid-answers stars comfort end))
  (preference-request (search-parameter stars) (request "How many stars would you like? "))
  (preference-request (search-parameter comfort) (request "Which comfort would you like to have? "))
)