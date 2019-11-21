(defmodule GENERATE-SOLUTIONS (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL) (import GENERATE-CITIES ?ALL) (import ITERATION-MANAGER ?ALL) (export ?ALL))

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

(deftemplate GENERATE-SOLUTIONS::solution
  (multislot facilities)
  (multislot cities)
  (slot certainty)
  (slot number-places (type INTEGER))
)

(defrule GENERATE-SOLUTIONS::start (declare (salience 10000))
  (iteration ?i)
  =>
  (assert (counter 5))
  (focus GENERATE-CITIES GENERATE-FACILITIES RETRACT-FACILITIES OPERATIONS-ON-FACILITIES)
)

; (defrule GENERATE-SOLUTIONS::find-one-place-solutions 
;   (iteration ?i)
;   ;(user-attribute (name number-places) (values 1))
;   ?counter <- (counter ?counter-value&:(> ?counter-value 0))
;   ?attribute-facility <- (attribute (name facility) (value ?name) (certainty ?cf-max) (iteration ?i)) 
;   (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max)) (iteration ?i)))
;   (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
;   =>
;   (assert 
;     (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (rooms-available ?rooms-available) (rooms-booked (+ ?rooms-available ?rooms-booked)) (certainty ?cf-max))
;   )  
;   (retract ?counter ?attribute-facility)
;   (assert (counter (- ?counter-value 1)))
; )

(defrule GENERATE-SOLUTIONS::generate-one-places-solutions
  (iteration ?i)

  (attribute (name facility) (value ?facility) (certainty ?cf) (iteration ?i))
  (facility (name ?facility) (city ?city))
  =>
  (assert (solution (facilities ?facility) (cities ?city) (certainty ?cf) (number-places 1)))
)

(defrule GENERATE-SOLUTIONS::generate-two-places-solutions
  (iteration ?i)
  (near-cities (city1 ?city1) (city2 ?city2) (distance-range ?distance-range))
  (cf-distance ?distance-range ?cf-distance)

  (solution (facilities ?facility1) (cities ?city1) (certainty ?cf1) (number-places 1)) 
  (solution (facilities ?facility2) (cities ?city2) (certainty ?cf2) (number-places 1)) 
  =>
  (bind ?min-cf (min ?cf1 ?cf2))
  (bind ?cf (- (+ ?min-cf ?cf-distance) (* ?min-cf ?cf-distance)))
  (assert (solution (facilities ?facility1 ?facility2) (cities ?city1 ?city2) (certainty ?cf) (number-places 2)))
)

(defrule GENERATE-SOLUTIONS::generate-three-places-solutions
  (iteration ?i)
  (near-cities (city1 ?city) (city2 ?city-near) (distance-range ?distance-range))
  (cf-distance ?distance-range ?cf-distance)

  (solution (facilities ?facility1) (cities ?city1&:(or (eq ?city1 ?city) (eq ?city1 ?city-near))) (certainty ?cf1) (number-places 1)) 
  (solution (facilities $?facilities2) (cities $?prev&:(not (member ?city1 ?prev)) ?city2&~?city1&:(or (eq ?city2 ?city) (eq ?city2 ?city-near)) $?next&:(not (member ?city1 ?next))) (certainty ?cf2) (number-places 2)) 
  =>
  (bind ?min-cf (min ?cf1 ?cf2))
  (bind ?cf (- (+ ?min-cf ?cf-distance) (* ?min-cf ?cf-distance)))
  (assert (solution (facilities ?facilities2 ?facility1) (cities $?prev ?city2 $?next ?city1) (certainty ?cf) (number-places 3))) 
)

(defrule GENERATE-SOLUTIONS::delete-solutions-with-same-cities-and-different-hotels-taking-the-maximun
  (solution (facilities $?facilities1) (cities $?cities) (certainty ?cf1) (number-places 3))
  ?solution-to-delete <- (solution (facilities $?facilities2&:(neq $?facilities2 $?facilities1)) (cities $?cities) (certainty ?cf2&:(<= ?cf2 ?cf1)) (number-places 3))
  =>
  (retract ?solution-to-delete)
)

; (defrule GENERATE-SOLUTIONS::decrease-number-places (declare (salience -1000))
;   (counter ?value&:(> ?value 0))
;   ?fact-number-places <- (user-attribute (name number-places) (values ?number-places&:(> ?number-places 1)))
;   =>
;   (modify ?fact-number-places (values (- ?number-places 1)))
; )

(defrule GENERATE-SOLUTIONS::end (declare (salience -10000))
  (iteration ?i)
  ?counter <- (counter ?x)
  =>
  (retract ?counter)
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)
