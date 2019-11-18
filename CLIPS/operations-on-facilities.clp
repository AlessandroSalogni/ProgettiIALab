(defmodule OPERATIONS-ON-FACILITIES (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL))

;Per gestione flusso
(defrule OPERATIONS-ON-FACILITIES::cf-contribution-from-availability
  (iteration ?i)
  ?attribute-facility <- (attribute (name facility) (value ?name) (iteration ?i)) 
  (facility (name ?name) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  ?considered <- (considered-hotels $?considered-hotels&:(not (member ?name $?considered-hotels)))
  =>
  (bind ?cf-contribution (+ (* (/ ?rooms-available (+ ?rooms-booked ?rooms-available)) 0.8) -0.4))
  (retract ?considered)
  (assert (considered-hotels $?considered-hotels ?name))
  (assert (attribute (name facility) (value ?name) (certainty ?cf-contribution) (iteration ?i)))
)

(deffacts OPERATIONS-ON-FACILITIES::initial-facts
  (considered-hotels)
)
