(defmodule PRINT-RESULTS (import EXTRACT-SOLUTIONS ?ALL))

(defrule PRINT-RESULTS::header (declare (salience 10))
  (iteration ?i)
  =>
  (printout t t)
  (printout t " ###### PROPOSED DESTINATIONS ######" t t)
  (printout t " ----------------------------------------------------------------------------------------------------------" t t)
)

(defrule PRINT-RESULTS::print-solution
  (iteration ?i)
  ?sol <- (solution (facilities ?first-facility $?facility) (certainty ?cf-max))
  (not (solution (certainty ?cf&:(> ?cf ?cf-max))))
  (facility (name ?first-facility) (city ?city) (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))
  =>
  (modify ?sol (facilities $?facility))
  (format t " %-35s %-20s% %d*%-10s %d€%-10s %d/%d %-15s %-5s %n" ?first-facility ?city ?stars "" ?price "" ?rooms-available (+ ?rooms-available ?rooms-booked) "rooms available" "")
  (printout t " Services: " $?services t t)
)

(defrule PRINT-RESULTS::retract-empty-solution
  (iteration ?i)
  ?sol <- (solution (facilities) (certainty ?cf))
  =>
  (retract ?sol)
  (format t " CERTAINTY FACTOR: %f%n%n" ?cf)
  (printout t " ----------------------------------------------------------------------------------------------------------" t t)
)