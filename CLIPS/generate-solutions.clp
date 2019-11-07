(defmodule GENERATE-SOLUTIONS (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL))

(deftemplate GENERATE-SOLUTIONS::solution
  (slot facility)
  (slot city)
  (slot price)
  (slot stars)
  (multislot service)
  (slot certainty)
)

(defrule GENERATE-SOLUTIONS::start
  (declare (salience 10000))
  =>
  (assert (counter 5))
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)

; (defrule GENERATE-SOLUTIONS::generate-single-solution
;   (attribute (name facility) (value ?name) (certainty ?cf&:(> ?cf 0)))
;   (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (service $?services))
;   =>
;   (assert 
;     (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (certainty ?cf))
;   )
; )

(defrule GENERATE-SOLUTIONS:find-5-solutions 
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  ?attribute-facility <- (attribute (name facility) (value ?name) (certainty ?cf-max))
  (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max))))
  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (services $?services))
  =>
  (assert 
    (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (certainty ?cf-max))
  )  
  (retract ?counter)
  (retract ?attribute-facility)
  (assert (counter (- ?counter-value 1)))
)