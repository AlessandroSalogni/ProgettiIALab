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
  (focus GENERATE-CITIES GENERATE-FACILITIES RETRACT-FACILITIES)
)

(defrule GENERATE-SOLUTIONS::find-solutions 
  (iteration ?i)
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  ?attribute-facility <- (attribute (name facility) (value ?name) (certainty ?cf-max) (iteration ?i)) ;TODO mettere una soglia minima di confidenza? Io ho messo 0 per ora ma forse di più
  (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max)) (iteration ?i)))
  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  =>
  (assert 
    (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (certainty ?cf-max))
  )  
  (retract ?counter ?attribute-facility)
  (assert (counter (- ?counter-value 1)))
)

; A 		B 			a 	b
; [0, 1] --> [-0.2, +0.2]
; (val - A)*(b-a)/(B-A) + a
; (occupation)*(0.4) -0.2

(defrule GENERATE-SOLUTIONS::cf-contribution-from-availability (declare (salience 1000))
  (iteration ?i)
  ?attribute-facility <- (attribute (name facility) (value ?name) (iteration ?i)) 
  (facility (name ?name) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  =>
  (bind ?cf-contribution (+ (* (/ ?rooms-booked (+ ?rooms-booked ?rooms-available)) 0.4) -0.2))
  (assert (attribute (name facility) (value ?name) (certainty ?cf-contribution) (iteration ?i)))
)

(defrule GENERATE-SOLUTIONS::end (declare (salience -10000))
  (iteration ?i)
  ?counter <- (counter ?x)
  =>
  (retract ?counter)
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)
