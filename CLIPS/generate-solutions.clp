(defmodule GENERATE-SOLUTIONS (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL))

(deftemplate GENERATE-SOLUTIONS::solution
  (slot facility (type STRING))
  (slot city (type STRING))
  (slot price (type INTEGER))
  (slot stars (type INTEGER) (range 1 4))
  (slot rooms-available (type INTEGER))
  (slot rooms-booked (type INTEGER))
  (multislot service)
  (slot certainty (type FLOAT))
)

(defrule GENERATE-SOLUTIONS::start (declare (salience 10000))
  (iteration ?i)
  =>
  (assert (counter 5))
  (focus GENERATE-CITIES GENERATE-FACILITIES RETRACT-FACILITIES OPERATIONS-ON-FACILITIES)
)

(defrule GENERATE-SOLUTIONS::find-solutions 
  (iteration ?i)
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  ?attribute-facility <- (attribute (name facility) (value ?name) (certainty ?cf-max) (iteration ?i)) ;TODO mettere una soglia minima di confidenza? Io ho messo 0 per ora ma forse di più
  (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max)) (iteration ?i)))
  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  =>
  (assert 
    (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (rooms-available ?rooms-available) (rooms-booked (+ ?rooms-available ?rooms-booked)) (certainty ?cf-max))
  )  
  (retract ?counter ?attribute-facility)
  (assert (counter (- ?counter-value 1)))
)

(defrule GENERATE-SOLUTIONS::end (declare (salience -10000))
  (iteration ?i)
  ?counter <- (counter ?x)
  =>
  (retract ?counter)
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)
