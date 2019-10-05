;;****************
;;* USER-PROFILE *
;;****************
(defmodule USER-PROFILE (import MAIN ?ALL))

(deftemplate profile
  (slot name (type STRING))
  (slot birth-year (type INTEGER))
  (slot live-region)
  (multislot comfort)
  (multislot turism)
)

(deffacts USER-PROFILE::profile-definition
  (profile (name "Riccardo Perotti") (birth-year 1996) (live-region piemonte) (comfort wifi) (turism mountain))
  (profile (name "Alessandro Salogni") (birth-year 1996) (live-region piemonte) (comfort tv pet) (turism sea sport))
)
