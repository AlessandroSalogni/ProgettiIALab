(defmodule GENERATE-SOLUTIONS (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL))

(deftemplate GENERATE-SOLUTIONS::solution
  (slot facility)
  (slot city)
  (slot price)
  (slot stars)
  (multislot service)
  (slot certainty)
)

(defrule GENERATE-SOLUTIONS::start (declare (salience 10000))
  (iteration ?i)
  =>
  (assert (counter 5))
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)

(defrule GENERATE-SOLUTIONS:find-5-solutions 
  (iteration ?i)
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  ?attribute-facility <- (attribute (name facility) (value ?name) (certainty ?cf-max) (iteration ?i))
  (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max)) (iteration ?i)))
  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (services $?services))
  (attribute (name city) (value ?city) (certainty ?cf-city&:(> ?cf-city -0.4)))
  =>
  (assert 
    (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (certainty ?cf-max))
  )  
  (retract ?counter)
  (retract ?attribute-facility)
  (assert (counter (- ?counter-value 1)))
)

(defrule GENERATE-SOLUTIONS:retract-counter
  ?counter <- (counter 0)
  =>
  (retract ?counter)
)