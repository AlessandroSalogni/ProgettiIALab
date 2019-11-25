(defmodule USER-ATTRIBUTE (export ?ALL))

(deftemplate USER-ATTRIBUTE::user-attribute
  (slot name)
  (multislot values)
  (slot desire (default TRUE) (allowed-symbols TRUE FALSE))
  (slot type (allowed-symbols mandatory optional profile inferred) (default optional))
  (slot id (default-dynamic (gensym*)))
)

(defrule USER-ATTRIBUTE::combine-enumeration-optional-or-profile-user-attribute (declare (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?val1) (desire ?desire) (type ?type&:(or (eq ?type profile) (eq ?type optional))))
  ?attr2 <- (user-attribute (name ?name) (values ?val2&:(and (not (member ?val2 $?val1)) (neq (type ?val2) INTEGER))) (desire ?desire) (type ?type))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
  (modify ?attr2 (values $?val1 ?val2))
)

(defrule USER-ATTRIBUTE::retract-duplicate-enumeration-optional-user-attribute (declare (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values ?val&:(neq (type ?val) INTEGER)) (desire ?desire) (type optional))
  ?attr2 <- (user-attribute (name ?name) (values $?prev ?val $?next) (desire ?desire) (type optional))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr1)
)

(defrule USER-ATTRIBUTE::retract-duplicate-range-optional-user-attribute (declare (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values ?val1&:(eq (type ?val1) INTEGER)) (type optional) (id ?id1))
  ?attr2 <- (user-attribute (name ?name) (values ?val2&:(eq (type ?val1) INTEGER)) (type optional) (id ?id2&:(> (str-compare ?id1 ?id2) 0)))
  =>
  (retract ?attr2)
)

(defrule USER-ATTRIBUTE::retract-contraddictory-optional-user-attribute (declare (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?prev1 ?val $?next1) (desire ?des1) (type optional) (id ?id1))
  ?attr2 <- (user-attribute (name ?name) (values $?prev2 ?val $?next2) (desire ?des2&~?des1) (type optional) (id ?id2&:(> (str-compare ?id1 ?id2) 0)))
  =>
  (modify ?attr2 (values $?prev2 $?next2)) 
)

(defrule USER-ATTRIBUTE::retract-duplicate-inferred-user-attribute (declare (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values ?val1) (type inferred) (id ?id1))
  ?attr2 <- (user-attribute (name ?name) (values ?val2) (type inferred) (id ?id2&:(> (str-compare ?id1 ?id2) 0)))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr2)
)

(defrule USER-ATTRIBUTE::override-mandatory-user-attribute (declare (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values ?value) (type optional))
  ?attr2 <- (user-attribute (name ?name) (type mandatory))
  =>
  (modify ?attr2 (values ?value))
  (retract ?attr1)
)