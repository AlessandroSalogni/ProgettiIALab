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
