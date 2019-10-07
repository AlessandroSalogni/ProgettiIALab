(defmodule MANDATORY-QUESTIONS (import MAIN ?ALL) (export ?ALL))

(deftemplate MANDATORY-QUESTIONS::mandatory-question
  (slot name)
  (slot question (type STRING))
)

(defrule MANDATORY-QUESTIONS::ask-mandatory-question-start
    =>
    (assert (prev others))
    (printout t "Name and surname? ")
    (bind ?answer (readline))
    (assert 
        (user-attribute 
            (name name-surname) 
            (value ?answer) 
            (type mandatory)
        )
    )
)

(defrule MANDATORY-QUESTIONS::ask-mandatory-question
    (prev others)
    (mandatory-question 
        (name ?name) 
        (question ?question) 
    )
    =>
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
    (mandatory-question (name number-people) (question "How many people? "))
    (mandatory-question (name number-days) (question "How many consecutive days? "))
)