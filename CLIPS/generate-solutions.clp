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

(defrule GENERATE-SOLUTIONS::find-one-place-solutions 
  (iteration ?i)
  (user-attribute (name number-places) (values 1))
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  ?attribute-facility <- (attribute (name facility) (value ?name) (certainty ?cf-max) (iteration ?i)) 
  (not (attribute (name facility) (certainty ?cf&:(> ?cf ?cf-max)) (iteration ?i)))
  (facility (name ?name) (city ?city) (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  =>
  (assert 
    (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (rooms-available ?rooms-available) (rooms-booked (+ ?rooms-available ?rooms-booked)) (certainty ?cf-max))
  )  
  (retract ?counter ?attribute-facility)
  (assert (counter (- ?counter-value 1)))
)

; (defrule GENERATE-SOLUTIONS::generate-two-places-solutions (declare (salience 1000))
;   (iteration ?i)
;   (user-attribute (name number-places) (values 2))

;   (attribute (name facility) (value ?name1) (certainty ?cf1) (iteration ?i))
;   (facility (name ?name1) (city ?city1) (price ?price1) (stars ?stars1) (services $?services1) (rooms-available ?rooms-available1) (rooms-booked ?rooms-booked1))  
  
;   (attribute (name facility) (value ?name2) (certainty ?cf2) (iteration ?i)) 
;   (facility (name ?name2) (city ?city2) (price ?price2) (stars ?stars2) (services $?services2) (rooms-available ?rooms-available2) (rooms-booked ?rooms-booked2))  

;   (or 
;     (city (name ?city1) (cities-from-0-to-29 $?cities0-29&:(member ?city2 $?cities0-29)))
;     (city (name ?city1) (cities-from-30-to-59 $?cities30-59&:(member ?city2 $?cities30-59)))
;     (city (name ?city1) (cities-from-60-to-89 $?cities60-89&:(member ?city2 $?cities60-89)))
;     (city (name ?city1) (cities-from-90-to-120 $?cities90-120&:(member ?city2 $?cities90-120)))
;   )

;   =>
;   ; (assert 
;   ;   (solution (facility ?name) (city ?city) (price ?price) (stars ?stars) (service ?services) (rooms-available ?rooms-available) (rooms-booked (+ ?rooms-available ?rooms-booked)) (certainty ?cf-max))
;   ; )  
; )

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
