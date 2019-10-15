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
    (values ?name-surname)
  )
  (local-time ?current-year $?)
  =>
  (assert (user-attribute (name age) (values (- ?current-year ?birth-year)) (type profile)))
  (assert (user-attribute (name number-holiday-days) (values ?number-holiday-days) (type profile)))
  (assert (user-attribute (name live-region) (values ?live-region) (type profile)))
  (assert (user-attribute (name last-holiday-region) (values ?last-holiday-region) (type profile)))
  (assert (user-attribute (name comforts) (values $?comforts) (type profile)))
  (assert (user-attribute (name favourite-turisms) (values $?favourite-turisms) (type profile)))
  ; (assert (new-profile-attributes comfort $?comforts))
  ; (assert (new-profile-attributes favourite-turism $?favourite-turisms))
)

(defrule USER-PROFILE::create-age-class
  (age-class ?class ?min ?max)
  (user-attribute (name age) (values ?age&:(and (>= ?age ?min) (<= ?age ?max))))
  =>
  (assert (user-attribute (name age-class) (values ?class) (type profile)))
)

; (defrule USER-PROFILE::generate-multislot-attributes
;   (new-profile-attributes ?attribute-name $? ?value $?)
;   =>
;   (assert (user-attribute (name ?attribute-name) (value ?value) (type profile)))
; )

(deffacts USER-PROFILE::profile-definition
  (age-class young 14 29)
  (age-class middle-young 30 49)
  (age-class middle-old 50 69)
  (age-class old 70 99)
  
  (local-time (local-time))
  
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
    (birth-year 1950)
    (number-holiday-days 7)
    (live-region lombardia)
    (last-holiday-region emilia-romagna)
    (comforts tv pet)
    (favourite-turisms sea sport))
)
