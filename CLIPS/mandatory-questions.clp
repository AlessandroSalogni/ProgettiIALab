(defmodule MANDATORY-QUESTIONS (import MAIN ?ALL) (import USER-INTERACTION ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL))

(deftemplate MANDATORY-QUESTIONS::mandatory-question
  (slot name)
  (slot question (type STRING))
  (slot start (allowed-symbols TRUE FALSE) (default TRUE))
  (slot next (default none))
  (slot already-asked (allowed-symbols TRUE FALSE) (default FALSE))
  (slot type (allowed-symbols free range enumeration) (default free))
)

(defrule MANDATORY-QUESTIONS::ask-next-order-mandatory-free-questions
  ?current <- (current-order-question ?name&~none)
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
  ?current <- (current-order-question ?name&~none)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
    (type range)
  )
  (parameter-range
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
  ?current <- (current-order-question none)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (start TRUE)
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
  ?current <- (current-order-question none)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (start TRUE)
    (next ?next)
    (already-asked FALSE)
    (type range)
  )
  (parameter-range 
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
  (mandatory-question (name number-days) (next budget-per-day) (question "How many consecutive days? ") (type range))
  (mandatory-question (name budget-per-day) (start FALSE) (question "How much is your budget per day ideally? ") (type range))
)
