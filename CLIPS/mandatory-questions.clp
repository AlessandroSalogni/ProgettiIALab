(defmodule MANDATORY-QUESTIONS (import MAIN ?ALL) (export ?ALL))

(deftemplate MANDATORY-QUESTIONS::mandatory-question
  (slot name)
  (slot question (type STRING))
  (slot next (default end))
  (slot already-asked (default FALSE))
)

(defrule MANDATORY-QUESTIONS::ask-next-order-mandatory-questions
  ?current <- (current-order-question ?name&~end)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
  )
  =>
  (retract ?current)
  (assert (current-order-question ?next))
  (modify ?q (already-asked TRUE))
  (printout t ?question)
  (bind ?answer (readline))
  (assert
    (user-attribute
      (name ?name)
      (value ?answer)
      (type mandatory)
    )
  )
)

(defrule MANDATORY-QUESTIONS::ask-mandatory-question
  ?current <- (current-order-question end)
  ?q <- (mandatory-question
    (name ?name)
    (question ?question)
    (next ?next)
    (already-asked FALSE)
  )
  =>
  (retract ?current)
  (assert (current-order-question ?next))
  (modify ?q (already-asked TRUE))
  (printout t ?question)
  (bind ?answer (read))
  (assert
    (user-attribute
      (name ?name)
      (value ?answer)
      (type mandatory)
    )
  )
)

(deffacts MANDATORY-QUESTIONS::define-mandatory-questions
  (current-order-question name-surname)
  (mandatory-question (name name-surname) (question "Name and surname? "))
  (mandatory-question (name number-people) (question "How many people? "))
  (mandatory-question (name number-days) (question "How many consecutive days? "))
)
