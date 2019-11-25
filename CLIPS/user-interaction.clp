(defmodule USER-INTERACTION (export ?ALL))

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

(deftemplate USER-INTERACTION::user-attribute
  (slot name)
  (multislot values)
  (slot desire (default TRUE) (allowed-symbols TRUE FALSE))
  (slot type (allowed-symbols mandatory optional profile inferred) (default optional))
  (slot id (default-dynamic (gensym*)))
)

(defrule USER-INTERACTION::combine-user-attribute
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?val1) (desire ?desire) (type ?type))
  ?attr2 <- (user-attribute (name ?name) (values ?val2&:(not (member ?val2 $?val1))) (desire ?desire) (type ?type))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (values $?val1 ?val2))
)

(defrule USER-INTERACTION::retract-duplicate-user-attribute
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values ?val) (desire ?desire) (type ?type))
  ?attr2 <- (user-attribute (name ?name) (values $?prev ?val $?next) (desire ?desire) (type ?type))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
)

(defrule USER-INTERACTION::override-mandatory-answers
  ?optional-user-attribute <- (user-attribute (name ?name) (values ?value) (type optional))
  ?user-attribute <- (user-attribute (name ?name) (type mandatory))
  =>
  (modify ?user-attribute (values ?value))
  (retract ?optional-user-attribute)
)

(defrule USER-INTERACTION::retract-override-user-attribute-class
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values ?val1) (type inferred) (id ?id1))
  ?attr2 <- (user-attribute (name ?name) (values ?val2) (type inferred) (id ?id2&:(> (str-compare ?id1 ?id2) 0)))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr2)
)

(defrule USER-INTERACTION::retract-contraddictory-user-attribute
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?prev1 ?val $?next1) (desire ?des1) (type ?type) (id ?id1))
  ?attr2 <- (user-attribute (name ?name) (values $?prev2 ?val $?next2) (desire ?des2&~?des1) (type ?type) (id ?id2&:(> (str-compare ?id1 ?id2) 0)))
  =>
  (modify ?attr2 (values $?prev2 $?next2)) 
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
    (question ?question)
    (valid-answers $?valid-answers)
  )
  =>
  (printout t ?question)
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

(defrule USER-INTERACTION::wrong-answer-enumeration-attribute-user-interaction
  ?user-question <- (enumeration-attribute-question
    (valid-answers $?valid-answers)
  )
  (or
    ?user-answer <- (enumeration-user-answer)
    ?user-answer <- (enumeration-user-answer ?answer&:(not (member ?answer ?valid-answers)))
    ?user-answer <- (enumeration-user-answer not ?answer&:(not (member ?answer ?valid-answers)))
    ?user-answer <- (enumeration-user-answer ?first&~not ?second)
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
  )
  =>
  (printout t ?question)
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