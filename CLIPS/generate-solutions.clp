(defmodule GENERATE-SOLUTIONS (import MAIN ?ALL) (import GENERATE-SOLUTIONS ?ALL))

(deftemplate GENERATE-SOLUTIONS::solution
  (slot facilitity)
  (slot city)
  (slot price)
  (slot stars)
  (slot service)
  (slot certainty)
)

(defrule GENERATE-SOLUTIONS::start
  (declare (salience 10000))
  =>
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)

(defrule GENERATE-SOLUTIONS::generate-single-solution
  (attribute (name facility) (value ?name) (certainty ?cf&:(> ?cf 0)))
  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (service $?services))
  =>
  (assert 
    (solution (faciltity ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (certainty ?cf))
  )
)

;TODO inizializzare counter
(defrule GENERATE-SOLUTIONS:find-bad-solutions (declare (salience 1000))
  ?counter <- (counter ?counter-value&:(> 0 ?counter-value))

  ?attribute-facility <- (attribute (name facility) (certainty ?cf-max))
  (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max))))

  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (service $?services))
  =>
  (assert 
    (solution (faciltity ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (certainty ?cf))
  )  
  (retract ?counter)
  (retract ?attribute-facility)
  (assert (counter (- ?counter-value 1)))
)