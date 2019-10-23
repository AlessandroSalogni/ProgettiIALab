(defmodule MANDATORY-QUESTIONS (import MAIN ?ALL) (import USER-INTERACTION ?ALL) (export ?ALL))

(deftemplate MANDATORY-QUESTIONS::mandatory-question
  (slot name)
  (slot question (type STRING))
  (slot next (default end))
  (slot already-asked (default FALSE))
  (slot type (allowed-symbols free range limit) (default free))
)

(defrule MANDATORY-QUESTIONS::ask-next-order-mandatory-free-questions
  ?current <- (current-order-question ?name&~end)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
    (type free)
  )
  =>
  (retract ?current)
  (assert (current-order-question ?next))
  (modify ?q (already-asked TRUE))
  (assert
    (free-attribute-question
      (name ?name)
      (question ?question)
    )
  )
  (focus USER-INTERACTION)
)

(defrule MANDATORY-QUESTIONS::ask-next-order-mandatory-range-questions
  ?current <- (current-order-question ?name&~end)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
    (type range)
  )
  (parameter 
    (name ?name)
    (range $?values)
  )
  =>
  (retract ?current)
  (assert (current-order-question ?next))
  (modify ?q (already-asked TRUE))
  (assert
    (range-attribute-question
      (name ?name)
      (question ?question)
      (range ?values)
    )
  )
  (focus USER-INTERACTION)
)

(defrule MANDATORY-QUESTIONS::ask-mandatory-free-question
  ?current <- (current-order-question end)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
    (type free)
  )
  =>
  (retract ?current)
  (assert (current-order-question ?next))
  (modify ?q (already-asked TRUE))
  (assert
    (free-attribute-question
      (name ?name)
      (question ?question)
    )
  )
  (focus USER-INTERACTION)
)

(defrule MANDATORY-QUESTIONS::ask-mandatory-range-question
  ?current <- (current-order-question end)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
    (type range)
  )
  (parameter 
    (name ?name)
    (range $?values)
  )
  =>
  (retract ?current)
  (assert (current-order-question ?next))
  (modify ?q (already-asked TRUE))
  (assert
    (range-attribute-question
      (name ?name)
      (question ?question)
      (range ?values)
    )
  )
  (focus USER-INTERACTION)
)

(deffacts MANDATORY-QUESTIONS::define-mandatory-questions
  (current-order-question name-surname)
  (mandatory-question (name name-surname) (question "Name and surname? "))
  (mandatory-question (name number-people) (question "How many people? ") (type range))
  (mandatory-question (name number-days) (next budget) (question "How many consecutive days? ") (type range))
  (mandatory-question (name budget-per-day) (question "How much is your budget per day? ") (type range))
)
