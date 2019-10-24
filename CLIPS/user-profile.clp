;;****************
;;* USER-PROFILE *
;;****************
(defmodule USER-PROFILE (import MAIN ?ALL) (export ?ALL))

(deftemplate profile
  (slot name-surname (type STRING))
  (slot birth-year (type INTEGER))
  (slot number-holiday-days (type INTEGER))
  (slot live-region)
  (slot last-region-visited)
  (multislot favourite-services)
  (multislot favourite-turisms)
)

(defrule USER-PROFILE::generate-slot-attributes
  (profile
    (name-surname ?name-surname)
    (birth-year ?birth-year)
    (number-holiday-days ?number-holiday-days)
    (live-region ?live-region)
    (last-region-visited ?last-region-visited)
    (favourite-services $?services)
    (favourite-turisms $?turisms)
  )
  (user-attribute
    (name name-surname)
    (values ?name-surname)
  )
  ; (local-time ?current-year $?)
  =>
  ; (assert (user-attribute (name age) (values (- ?current-year ?birth-year)) (type profile)))
  (assert (user-attribute (name age) (values 65) (type profile)))
  (assert (user-attribute (name number-holiday-days) (values ?number-holiday-days) (type profile)))
  (assert (user-attribute (name live-region) (values ?live-region) (type profile)))
  (assert (user-attribute (name last-region-visited) (values ?last-region-visited) (type profile)))
  (assert (user-attribute (name service) (values $?services) (type profile)))
  (assert (user-attribute (name turism) (values $?turisms) (type profile)))
)

(deffacts USER-PROFILE::profile-definition
  (class-attribute (user-attribute age) (attribute-name age-class) (class-name young) (min 14) (max 29))
  (class-attribute (user-attribute age) (attribute-name age-class) (class-name middle-young) (min 30) (max 49))
  (class-attribute (user-attribute age) (attribute-name age-class) (class-name middle-old) (min 50) (max 69))
  (class-attribute (user-attribute age) (attribute-name age-class) (class-name old) (min 70) (max 99))
  
  (class-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name low) (min 0) (max 49))
  (class-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name middle) (min 50) (max 149))
  (class-attribute (user-attribute budget-per-day) (attribute-name budget-per-day-class) (class-name high) (min 150) (max 300))

  ; (local-time (local-time))
  
  (profile
    (name-surname "Riccardo Perotti")
    (birth-year 1996)
    (number-holiday-days 10)
    (live-region piemonte)
    (last-region-visited liguria)
    (favourite-services wifi)
    (favourite-turisms mountain)
  )
  (profile
    (name-surname "Alessandro Salogni")
    (birth-year 1950)
    (number-holiday-days 7)
    (live-region lombardia)
    (last-region-visited emilia-romagna)
    (favourite-services tv pet)
    (favourite-turisms sea sport))
)