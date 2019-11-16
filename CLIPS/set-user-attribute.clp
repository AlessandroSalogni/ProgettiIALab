(defmodule SET-USER-ATTRIBUTE (import MAIN ?ALL) (import USER-INTERACTION ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL))

(deftemplate SET-USER-ATTRIBUTE::class-user-attribute
  (slot user-attribute)
  (slot attribute-name)
  (slot class-name)
  (slot min (type INTEGER))
  (slot max (type INTEGER))
)

(defrule SET-USER-ATTRIBUTE::start-first-iteration (declare (salience 10000))
  (iteration ?i&:(eq ?i 1))
	=>
	(focus MANDATORY-QUESTIONS USER-PROFILE OPTIONAL-QUESTIONS)
)

(defrule SET-USER-ATTRIBUTE::start-other-iteration (declare (salience 10000))
  (iteration ?i&:(neq ?i 1))
	=>
	(focus OPTIONAL-QUESTIONS)
)

(defrule SET-USER-ATTRIBUTE::combine-user-attribute
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?val1) (type ?type))
  ?attr2 <- (user-attribute (name ?name) (values ?val2&:(not (member ?val2 $?val1))) (type ?type))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr2)
  (modify ?attr1 (values $?val1 ?val2))
)

(defrule SET-USER-ATTRIBUTE::retract-duplicate-user-attribute
  (declare (salience 100) (auto-focus TRUE))
  ?attr1 <- (user-attribute (name ?name) (values $?val1) (type ?type))
  ?attr2 <- (user-attribute (name ?name) (values ?val2&:(member ?val2 $?val1)) (type ?type))
  (test (neq ?attr1 ?attr2))
  =>
  (retract ?attr2)
)

(defrule SET-USER-ATTRIBUTE::create-user-attribute-class
  (class-user-attribute 
    (user-attribute ?user-attribute) 
    (attribute-name ?attribute-name)
    (class-name ?class-name) 
    (min ?min) 
    (max ?max)
  )
  (user-attribute (name ?user-attribute) (values ?value&:(and (<= ?min ?value) (<= ?value ?max)))) ; TODO non scatta se viene fatta prima la combine
  =>
  (assert (user-attribute (name ?attribute-name) (values ?class-name) (type inferred)))
)

(defrule SET-USER-ATTRIBUTE::convert-optional-user-attribute
  (iteration ?i)
  (user-attribute (name ?name) (values $? ?value $?) (type optional))
  =>
  (assert (attribute (name ?name) (value ?value) (iteration ?i)))
)

(defrule SET-USER-ATTRIBUTE::convert-profile-user-attribute
  (iteration ?i)
  (user-attribute 
    (name ?name&:(or (eq ?name turism) (eq ?name service))) 
    (values $? ?value $?) 
    (type profile)
  )
  =>
  (assert (attribute (name ?name) (value ?value) (certainty 0.4) (iteration ?i)))
)

(deffacts SET-USER-ATTRIBUTE::define-class-user-attribute
  (class-user-attribute (user-attribute age) (attribute-name age-class) (class-name young) (min 14) (max 29))
  (class-user-attribute (user-attribute age) (attribute-name age-class) (class-name middle-young) (min 30) (max 49))
  (class-user-attribute (user-attribute age) (attribute-name age-class) (class-name middle-old) (min 50) (max 69))
  (class-user-attribute (user-attribute age) (attribute-name age-class) (class-name old) (min 70) (max 99))
  (class-user-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name low) (min 0) (max 49))
  (class-user-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name middle-low) (min 50) (max 99))
  (class-user-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name middle-high) (min 100) (max 149))
  (class-user-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name high) (min 150) (max 300))
)