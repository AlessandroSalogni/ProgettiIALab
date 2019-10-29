(defmodule USER-INTERACTION (import MAIN ?ALL) (export ?ALL))

(deffunction USER-INTERACTION::ask-question (?question ?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) then (bind ?answer (lowcase ?answer))))
   ?answer
)

(deftemplate USER-INTERACTION::menu-question
  (slot question (type STRING))
  (multislot valid-answers)
)

(deftemplate USER-INTERACTION::contradictory-resolution-question
  (slot name)
  (slot value)
  (slot question (type STRING))
)

(deftemplate USER-INTERACTION::free-attribute-question
  (slot name)
  (slot question (type STRING))
  (slot type-user-interaction (allowed-symbols mandatory optional) (default mandatory))
)

(deftemplate USER-INTERACTION::enumeration-attribute-question
  (slot name)
  (slot question (type STRING))
  (slot type-user-interaction (allowed-symbols mandatory optional) (default mandatory))
  (multislot valid-answers)
)

(deftemplate USER-INTERACTION::range-attribute-question
  (slot name)
  (slot question (type STRING))
  (slot type-user-interaction (allowed-symbols mandatory optional) (default mandatory))
  (multislot range (cardinality 2 2) (type INTEGER))
)

(defrule USER-INTERACTION::menu-user-interaction
  ?user-question <- (menu-question
    (question ?question)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?user-question)
  (assert (search-parameter (ask-question ?question ?valid-answers)))
)

(defrule USER-INTERACTION::contradictory-resolution-user-interaction
  ?user-question <- (contradictory-resolution-question
    (name ?name)
    (value ?value)
    (question ?question)
  )
  =>
  (retract ?user-question)
  (assert (user-value (ask-question ?question y n))
)

(defrule USER-INTERACTION::free-attribute-user-interaction
  ?user-question <- (free-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
  )
  =>
  (retract ?user-question)
  (printout t ?question)
  (bind ?answer (readline))
  (assert
    (user-attribute
      (name ?name)
      (values ?answer)
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::enumeration-attribute-user-interaction
  ?user-question <- (enumeration-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
    (valid-answers $?valid-answers)
  )
  =>
  (retract ?user-question)
  (assert
    (user-attribute
      (name ?name)
      (values (ask-question ?question ?valid-answers))
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::range-attribute-user-interaction
  (range-attribute-question
    (name ?name)
    (question ?question)
  )
  =>
  (printout t ?question)
  (bind ?answer (read))
  (assert (user-value ?answer))
)

(defrule USER-INTERACTION::correct-range-attribute-user-interaction
  ?user-value <- (user-value ?answer)
  ?user-question <- (range-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
    (range ?min&:(<= ?min ?answer) ?max&:(<= ?answer ?max))
  )
  =>
  (retract ?user-value)
  (retract ?user-question)
  (assert
    (user-attribute
      (name ?name)
      (values ?answer)
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::wrong-range-attribute-user-interaction
  ?user-value <- (user-value ?answer)
  ?user-question <- (range-attribute-question
    (range ?min ?max)
  )
  (test (or (< ?answer ?min) (< ?max ?answer)))
  =>
  (retract ?user-value)
  (duplicate ?user-question)
  (retract ?user-question)
)