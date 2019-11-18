(defmodule PRINT-RESULTS (import GENERATE-SOLUTIONS ?ALL) (import ITERATION-MANAGER ?ALL))

(defrule PRINT-RESULTS::header (declare (salience 10))
  (iteration ?i)
  =>
  (printout t t)
  (printout t "        SELECTED DESTINATIONS" t t)
  (printout t " -------------------------------" t t)
)

(defrule PRINT-RESULTS::print-solution
  ?sol <- (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked) (certainty ?cf-max))
  (not (solution (certainty ?cf&:(> ?cf ?cf-max))))
  =>
  (retract ?sol)
  (format t " %-35s %-20s% %d*%-10s %d€%-10s %d/%d rooms a.%-5s %f%n" ?name ?city ?stars "" ?price "" ?rooms-available (+ ?rooms-available ?rooms-booked) "" ?cf-max)
)

(defrule PRINT-RESULTS::end-iteration (declare (salience -10))
  (iteration ?i)
  =>
  (printout t t)
)
