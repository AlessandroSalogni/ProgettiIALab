(defmodule USER-INTERACTION (import USER-ATTRIBUTE ?ALL) (export ?ALL))

(deffunction USER-INTERACTION::ask-question (?question ?allowed-values)
   (printout t ?question " " ?allowed-values " ")
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

(defrule USER-INTERACTION::free-attribute-user-interaction
  ?user-question <- (free-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
  )
  =>
  (retract ?user-question)
  (printout t ?question " ")
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
    (question ?question)
    (valid-answers $?valid-answers)
  )
  =>
  (printout t ?question " " ?valid-answers " ")
  (assert (enumeration-user-answer (explode$ (readline))))
)

(defrule USER-INTERACTION::desire-enumeration-attribute-user-interaction
  ?user-question <- (enumeration-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
    (valid-answers $?valid-answers)
  )
  ?user-answer <- (enumeration-user-answer ?answer&:(member ?answer ?valid-answers))
  =>
  (retract ?user-answer ?user-question)
  (assert
    (user-attribute
      (name ?name)
      (values ?answer)
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::not-desire-enumeration-attribute-user-interaction
  ?user-question <- (enumeration-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
    (valid-answers $?valid-answers)
  )
  ?user-answer <- (enumeration-user-answer not ?answer&:(member ?answer ?valid-answers))
  =>
  (retract ?user-answer ?user-question)
  (assert
    (user-attribute
      (name ?name)
      (values ?answer)
      (desire FALSE)
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::maybe-desire-enumeration-attribute-user-interaction
  ?user-question <- (enumeration-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
    (valid-answers $?valid-answers)
  )
  ?user-answer <- (enumeration-user-answer maybe ?answer&:(member ?answer ?valid-answers))
  =>
  (retract ?user-answer ?user-question)
  (assert
    (user-attribute
      (name ?name)
      (values ?answer)
      (desire MAYBE)
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::wrong-answer-enumeration-attribute-user-interaction
  ?user-question <- (enumeration-attribute-question
    (valid-answers $?valid-answers)
  )
  (or
    ?user-answer <- (enumeration-user-answer)
    ?user-answer <- (enumeration-user-answer ?answer&:(not (member ?answer ?valid-answers)))
    ?user-answer <- (enumeration-user-answer not|maybe ?answer&:(not (member ?answer ?valid-answers)))
    ?user-answer <- (enumeration-user-answer ?first&~not&~maybe ?second)
    ?user-answer <- (enumeration-user-answer ?first ?second ?third $?others)
  )
  =>
  (duplicate ?user-question)
  (retract ?user-answer ?user-question)
)

(defrule USER-INTERACTION::range-attribute-user-interaction
  (range-attribute-question
    (name ?name)
    (question ?question)
    (range ?min ?max)
  )
  =>
  (printout t ?question " (from " ?min " to " ?max ") ")
  (bind ?answer (read))
  (assert (range-user-answer ?answer))
)

(defrule USER-INTERACTION::correct-range-attribute-user-interaction
  ?user-answer <- (range-user-answer ?answer)
  ?user-question <- (range-attribute-question
    (name ?name)
    (question ?question)
    (type-user-interaction ?type-interaction)
    (range ?min&:(<= ?min ?answer) ?max&:(<= ?answer ?max))
  )
  =>
  (retract ?user-answer ?user-question)
  (assert
    (user-attribute
      (name ?name)
      (values ?answer)
      (type ?type-interaction)
    )
  )
)

(defrule USER-INTERACTION::wrong-range-attribute-user-interaction
  ?user-answer <- (range-user-answer ?answer)
  ?user-question <- (range-attribute-question
    (range ?min ?max)
  )
  (test (or (< ?answer ?min) (< ?max ?answer)))
  =>
  (duplicate ?user-question)
  (retract ?user-answer ?user-question)
)