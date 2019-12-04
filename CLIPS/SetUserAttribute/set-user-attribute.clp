(defmodule SET-USER-ATTRIBUTE (import MAIN ?ALL) (export ?ALL))

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

(defrule SET-USER-ATTRIBUTE::create-user-attribute-class
  (class-user-attribute 
    (user-attribute ?user-attribute) 
    (attribute-name ?attribute-name)
    (class-name ?class-name) 
    (min ?min) 
    (max ?max)
  )
  (user-attribute (name ?user-attribute) (values ?value&:(and (<= ?min ?value) (<= ?value ?max))))
  =>
  (assert (user-attribute (name ?attribute-name) (values ?class-name) (type inferred)))
)

(defrule SET-USER-ATTRIBUTE::convert-desire-optional-user-attribute
  (iteration ?i)
  (user-attribute (name ?name) (values $? ?value $?) (desire TRUE) (type optional))
  =>
  (assert (attribute (name ?name) (value ?value) (iteration ?i)))
)

(defrule SET-USER-ATTRIBUTE::convert-not-desire-optional-user-attribute
  (iteration ?i)
  (user-attribute (name ?name) (values $? ?value $?) (desire FALSE) (type optional))
  =>
  (assert (attribute (name ?name) (value ?value) (certainty -0.99) (iteration ?i)))
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
  (class-user-attribute (user-attribute number-days) (attribute-name number-days-class) (class-name few-days) (min 1) (max 9))
  (class-user-attribute (user-attribute number-days) (attribute-name number-days-class) (class-name medium-days) (min 10) (max 19))
  (class-user-attribute (user-attribute number-days) (attribute-name number-days-class) (class-name lot-days) (min 20) (max 30))
)