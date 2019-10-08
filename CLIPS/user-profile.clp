;;****************
;;* USER-PROFILE *
;;****************
(defmodule USER-PROFILE (import MAIN ?ALL) (export ?ALL))

(deftemplate profile
  (slot name-surname (type STRING))
  (slot birth-year (type INTEGER))
  (slot number-holiday-days (type INTEGER))
  (slot live-region)
  (slot last-holiday-region)
  (multislot comforts)
  (multislot favourite-turisms)
)

(defrule USER-PROFILE::generate-slot-attributes
  (profile
    (name-surname ?name-surname)
    (birth-year ?birth-year)
    (number-holiday-days ?number-holiday-days)
    (live-region ?live-region)
    (last-holiday-region ?last-holiday-region)
    (comforts $?comforts)
    (favourite-turisms $?favourite-turisms)
  )
  (user-attribute
    (name name-surname)
    (value ?name-surname)
  )
  =>
  (assert (user-attribute (name birth-year) (value ?birth-year) (type profile)))
  (assert (user-attribute (name number-holiday-days) (value ?number-holiday-days) (type profile)))
  (assert (user-attribute (name live-region) (value ?live-region) (type profile)))
  (assert (user-attribute (name last-holiday-region) (value ?last-holiday-region) (type profile)))
  (assert (comforts $?comforts))
  (assert (favourite-turisms $?favourite-turisms))
)

(defrule USER-PROFILE::generate-comforts-attributes
  ?profile-comforts <- (comforts $?comforts ?comfort)
  =>
  (assert (user-attribute (name comfort) (value ?comfort) (type profile)))
  (retract ?profile-comforts)
  (assert (comforts $?comforts))
)

(defrule USER-PROFILE::generate-turisms-attributes
  ?profile-favourite-turisms <- (favourite-turisms $?favourite-turisms ?favourite-turism)
  =>
  (assert (user-attribute (name favourite-turism) (value ?favourite-turism) (type profile)))
  (retract ?profile-favourite-turisms)
  (assert (favourite-turisms $?favourite-turisms))
)

(deffacts USER-PROFILE::profile-definition
  (profile
    (name-surname "Riccardo Perotti")
    (birth-year 1996)
    (number-holiday-days 10)
    (live-region piemonte)
    (last-holiday-region liguria)
    (comforts wifi)
    (favourite-turisms mountain)
  )
  (profile
    (name-surname "Alessandro Salogni")
    (birth-year 1996)
    (number-holiday-days 7)
    (live-region lombardia)
    (last-holiday-region emilia-romagna)
    (comforts tv pet)
    (favourite-turisms sea sport))
)
