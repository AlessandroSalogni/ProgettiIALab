;;****************
;;* DESTINATIONS *
;;****************
(defmodule DESTINATIONS (import MAIN ?ALL))

(defrule DESTINATIONS::start
	(declare (salience 10000))
	=>
	(focus GENERATE-CITIES GENERATE-FACILITIES)
)