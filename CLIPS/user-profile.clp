(defmodule USER-PROFILE (import USER-ATTRIBUTE ?ALL) (export ?ALL))

(deftemplate profile ;TODO trattare anche cose che non piacciono ??
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
    (live-region ?live-region)
    (last-region-visited ?last-region-visited)
    (favourite-services $?services)
    (favourite-turisms $?turisms)
  )
  (user-attribute
    (name name-surname)
    (values ?name-surname)
  )
  (current-year ?current-year)
  =>
  (assert (user-attribute (name age) (values (- ?current-year ?birth-year)) (type profile)))
  (assert (user-attribute (name live-region) (values ?live-region) (type profile)))
  (assert (user-attribute (name last-region-visited) (values ?last-region-visited) (type profile)))
  (assert (user-attribute (name service) (values $?services) (type profile)))
  (assert (user-attribute (name turism) (values $?turisms) (type profile)))
)

(deffacts USER-PROFILE::profile-definition
  (current-year 2019)
  
  (profile
    (name-surname "Riccardo Perotti")
    (birth-year 1996)
    (live-region piemonte)
    (last-region-visited liguria)
    (favourite-services wifi parking pool)
    (favourite-turisms mountain termal)
  )
  (profile
    (name-surname "Alessandro Salogni")
    (birth-year 1950)
    (live-region lombardia)
    (last-region-visited emilia-romagna)
    (favourite-services tv pet)
    (favourite-turisms sea sport))
)