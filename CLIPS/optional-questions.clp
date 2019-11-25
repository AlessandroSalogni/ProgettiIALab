(defmodule OPTIONAL-QUESTIONS (import MAIN ?ALL) (export ?ALL))

(deftemplate OPTIONAL-QUESTIONS::menu-request
  (slot search-parameter)
  (slot request (type STRING))
  (multislot valid-answers)
)

(deftemplate OPTIONAL-QUESTIONS::preference-request
  (slot search-parameter)
  (slot request (type STRING))
)

(defrule OPTIONAL-QUESTIONS::leave-focus
  ?search-parameter <- (search-parameter end)
  ?history <- (search-parameter-history start)
  =>
  (retract ?search-parameter)
  (assert (search-parameter start))
  (retract ?history)
  (assert (search-parameter-history))
  (return)
)

(defrule OPTIONAL-QUESTIONS::leave-request
  ?search-parameter <- (search-parameter end)
  ?history <- (search-parameter-history $?history-parameter ?prev-parameter ?current-parameter)
  =>
  (retract ?search-parameter)
  (assert (search-parameter ?prev-parameter))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter))
)

(defrule OPTIONAL-QUESTIONS::start-menu-request
  ?search-parameter <- (search-parameter start)
  ?history <- (search-parameter-history)
  (menu-request
    (search-parameter start)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (retract ?history)
  (assert (search-parameter-history start))
  (assert 
    (menu-question
      (question ?request)
      (valid-answers ?valid-answers)
    )
  )
  (focus USER-INTERACTION)
)

(defrule OPTIONAL-QUESTIONS::menu-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (menu-request
    (search-parameter ?parameter)
    (request ?request)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (assert 
    (menu-question
      (question ?request)
      (valid-answers ?valid-answers)
    )
  )
  (focus USER-INTERACTION)
)

(defrule OPTIONAL-QUESTIONS::enumeration-preference-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (preference-request
    (search-parameter ?parameter)
    (request ?request)
  )
  (parameter-enumeration
    (name ?parameter)
    (values $?valid-answers)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (assert 
    (enumeration-attribute-question
      (name ?parameter)
      (question ?request)
      (type-user-interaction optional)
      (valid-answers ?valid-answers)
    )
  )
  (focus USER-INTERACTION)
)

(defrule OPTIONAL-QUESTIONS::range-preference-request
  ?search-parameter <- (search-parameter ?parameter&~start&~end)
  ?history <- (search-parameter-history $?history-parameter)
  (preference-request
    (search-parameter ?parameter)
    (request ?request)
  )
  (parameter-range
    (name ?parameter)
    (range $?range)
  )
  =>
  (retract ?search-parameter)
  (assert (search-parameter end))
  (retract ?history)
  (assert (search-parameter-history $?history-parameter ?parameter))
  (assert 
    (range-attribute-question
      (name ?parameter)
      (question ?request)
      (type-user-interaction optional)
      (range ?range)
    )
  )
  (focus USER-INTERACTION)
)

(deffacts OPTIONAL-QUESTIONS::define-requests
  (search-parameter start)
  (search-parameter-history)
  (menu-request (search-parameter start) (request "Which search parameter would you like to set? ") (valid-answers destination facility end))
  (menu-request (search-parameter destination) (request "Which search parameter of destination would you like to set? ") (valid-answers region turism number-places end))
  (preference-request (search-parameter turism) (request "Which turism do you prefer? "))
  (preference-request (search-parameter region) (request "Which region would you like to visit? "))
  (preference-request (search-parameter number-places) (request "How many places would you like to visit? "))
  (preference-request (search-parameter budget) (request "How much budget? "))
  (menu-request (search-parameter facility) (request "Which search parameter of facility would you like to set? ") (valid-answers stars service budget-per-day end))
  (preference-request (search-parameter stars) (request "How many stars would you like? "))
  (preference-request (search-parameter service) (request "Which service would you like to have? "))
  (preference-request (search-parameter budget-per-day) (request "What budget per day would you like to set? "))
)
