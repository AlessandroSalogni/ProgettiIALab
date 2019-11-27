(defmodule EXTRACT-SOLUTIONS (import GENERATE-FACILITIES ?ALL) (import GENERATE-SOLUTIONS ?ALL) (export ?ALL))

(deftemplate EXTRACT-SOLUTIONS::solution
  (multislot facilities (type STRING))
  (slot certainty (type FLOAT))
)

(defrule EXTRACT-SOLUTIONS::start (declare (salience 10000))
  (iteration ?i)
  =>
  (assert (counter 5))
  (focus GENERATE-CITIES GENERATE-FACILITIES RETRACT-FACILITIES GENERATE-SOLUTIONS)
)

(defrule EXTRACT-SOLUTIONS::extract-max-5-solutions
  (iteration ?i)
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  (user-attribute (name number-places) (values ?n-max))

  ?sol <- (possible-solution (facilities $?facilities) (certainty ?cf-max) (number-places ?n-max))
  (not (possible-solution (certainty ?cf&:(> ?cf ?cf-max)) (number-places ?n-max)))
  =>
  (assert (solution (facilities ?facilities) (certainty ?cf-max)))  
  (retract ?counter ?sol)
  (assert (counter (- ?counter-value 1)))
)

(defrule EXTRACT-SOLUTIONS::end (declare (salience -10000))
  (or
    ?fact <- (possible-solution)
    ?fact <- (counter ?x)
  )
  =>
  (retract ?fact)
)