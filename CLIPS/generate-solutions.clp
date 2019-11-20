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

;****************************************************************************
;****************************************************************************
;****************************** multilocalita *******************************
;****************************************************************************
;****************************************************************************
(defrule GENERATE-SOLUTIONS::generate-one-places-solutions
  (iteration ?i)

  (attribute (name facility) (value ?facility) (certainty ?cf) (iteration ?i))
  (facility (name ?facility) (city ?city))
  =>
  (assert (solution (facilities ?facility) (cities ?city) (certainty ?cf) (number-places 1)))
)

(defrule GENERATE-SOLUTIONS::generate-two-places-solutions-under-30
  (iteration ?i)
  (near-cities (city1 ?city1) (city2 ?city2) (distance-range under-30))

  (solution (facilities ?facility1) (cities ?city1) (certainty ?cf1) (number-places 1)) 
  (solution (facilities ?facility2) (cities ?city2) (certainty ?cf2) (number-places 1)) 
  =>
  (bind ?min-cf (min ?cf1 ?cf2))
  (bind ?cf (- (+ ?min-cf 0.4) (* ?min-cf 0.4)))
  (assert (solution (facilities ?facility1 ?facility2) (cities ?city1 ?city2) (certainty ?cf) (number-places 2))))

(defrule GENERATE-SOLUTIONS::generate-two-places-solutions-under-60
  (iteration ?i)
  (near-cities (city1 ?city1) (city2 ?city2) (distance-range under-60))

  (solution (facilities ?facility1) (cities ?city1) (certainty ?cf1) (number-places 1)) 
  (solution (facilities ?facility2) (cities ?city2) (certainty ?cf2) (number-places 1)) 
  =>
  (bind ?min-cf (min ?cf1 ?cf2))
  (bind ?cf (- (+ ?min-cf 0.4) (* ?min-cf 0.4)))
  (assert (solution (facilities ?facility1 ?facility2) (cities ?city1 ?city2) (certainty ?cf) (number-places 2)))
)

(defrule GENERATE-SOLUTIONS::generate-two-places-solutions-under-100
  (iteration ?i)
  (near-cities (city1 ?city1) (city2 ?city2) (distance-range under-100))

  (solution (facilities ?facility1) (cities ?city1) (certainty ?cf1) (number-places 1)) 
  (solution (facilities ?facility2) (cities ?city2) (certainty ?cf2) (number-places 1)) 
  =>
  (bind ?min-cf (min ?cf1 ?cf2))
  (bind ?cf (- (+ ?min-cf 0.4) (* ?min-cf 0.4)))
  (assert (solution (facilities ?facility1 ?facility2) (cities ?city1 ?city2) (certainty ?cf) (number-places 2))))

(defrule GENERATE-SOLUTIONS::generate-three-places-solutions
  (iteration ?i)
  (near-cities (city1 ?city1) (city2 ?city2) (distance-range under-100))

  (solution (facilities ?facility1) (cities ?city1) (certainty ?cf1) (number-places 1)) 

  ?first-solution <- (two-places-solution $?prev-facility1 ?facility $?next-facility1 $?prev-city1 ?city $?next-city1 ?cf1)
  ?second-solution <- (two-places-solution $?prev-facility2 ?facility $?next-facility2 $?prev-city2 ?city $?next-city2 ?cf2)
  (test (neq ?first-solution ?second-solution))
  =>
  (bind ?min-cf (min ?cf1 ?cf2))
  (assert (three-places-solution $?prev-facility1 $?next-facility1 ?facility $?prev-facility2 $?next-facility2 
    $?prev-city1 $?next-city1 ?city $?prev-city2 $?next-city2 ?min-cf)) 
)


; (defrule GENERATE-SOLUTIONS::generate-two-places-solutions (declare (salience 1000))
;   (iteration ?i)
;   (attribute (name facility) (value ?facility) (certainty ?cf1) (iteration ?i))
;   (facility (name ?facility) (city ?city)); (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  
;   (or 
;     (and
;       (cf-cities-from-0-to-29 ?cf-distance) 
;       (city (name ?city) (cities-from-0-to-29 $?prev ?near-cities $?next))
;     )
;     (and
;       (cf-cities-from-30-to-59 ?cf-distance) 
;       (city (name ?city) (cities-from-30-to-59 $?prev ?near-cities $?next))
;     )
;     (and
;       (cf-cities-from-60-to-89 ?cf-distance)
;       (city (name ?city) (cities-from-60-to-89 $?prev ?near-cities $?next))
;     )
;     (and 
;       (cf-cities-from-90-to-120 ?cf-distance)
;       (city (name ?city) (cities-from-90-to-120 $?prev ?near-cities $?next))
;     )
;   )

;   (attribute (name facility) (value ?near-facility) (certainty ?cf2) (iteration ?i))
;   (facility (name ?near-facility) (city ?near-cities)); (price ?price) (stars ?stars) (services $?services) (rooms-available ?rooms-available) (rooms-booked ?rooms-booked))  
  
;   (not (two-places-solution ?near-facility ?facility $?))
;   =>
;   (assert (two-places-solution ?facility ?near-facility ?city ?near-cities (* (+ ?cf1 ?cf2) ?cf-distance))) 
; )


; (defrule GENERATE-SOLUTIONS::generate-two-places-solutions (declare (salience 1000))
;   (iteration ?i)
;   ;(user-attribute (name number-places) (values 2))

;   (attribute (name facility) (value ?name1) (certainty ?cf1) (iteration ?i))
;   (attribute (name facility) (value ?name2&~?name1) (certainty ?cf2) (iteration ?i)) 

;   (facility (name ?name1) (city ?city1) (price ?price1) (stars ?stars1) (services $?services1) (rooms-available ?rooms-available1) (rooms-booked ?rooms-booked1))  
;   (facility (name ?name2) (city ?city2&~?city1) (price ?price2) (stars ?stars2) (services $?services2) (rooms-available ?rooms-available2) (rooms-booked ?rooms-booked2))  

;   (not (two-places-solution ?name1 ?name2 ?city1 ?city2 $?cfs))
;   (not (two-places-solution ?name2 ?name1 ?city2 ?city1 $?cfs))

;   (or 
;     (and
;       (cf-cities-from-0-to-29 ?cf-distance) 
;       (city (name ?city1) (cities-from-0-to-29 $?cities0-29&:(member ?city2 $?cities0-29)))
;     )
;     (and
;       (cf-cities-from-30-to-59 ?cf-distance) 
;       (city (name ?city1) (cities-from-30-to-59 $?cities30-59&:(member ?city2 $?cities30-59)))
;     )
;     (and
;       (cf-cities-from-60-to-89 ?cf-distance)
;       (city (name ?city1) (cities-from-60-to-89 $?cities60-89&:(member ?city2 $?cities60-89))) 
;     )
;     (and 
;       (cf-cities-from-90-to-120 ?cf-distance)
;       (city (name ?city1) (cities-from-90-to-120 $?cities90-120&:(member ?city2 $?cities90-120)))
;     )
;   )
;   =>
;   (assert (two-places-solution ?name1 ?name2 ?city1 ?city2 (* (+ ?cf1 ?cf2) ?cf-distance))) 
; )

; (defrule GENERATE-SOLUTIONS::generate-three-places-solutions (declare (salience 100))
;   (iteration ?i)
;   ;(user-attribute (name number-places) (values 3))

;   (two-places-solution ?name1 ?name2 ?city1 ?city2 ?cf-2-places)  

;   (attribute (name facility) (value ?name3) (certainty ?cf3) (iteration ?i))
;   (facility (name ?name3&:(and (neq ?name1 ?name3)(neq ?name2 ?name3))) (city ?city3&:(and (neq ?city1 ?city3)(neq ?city2 ?city3))) (price ?price3) (stars ?stars3) (services $?services3) (rooms-available ?rooms-available3) (rooms-booked ?rooms-booked3))  

;   (or
;   (or 
;     (and
;       (cf-cities-from-0-to-29 ?cf-distance) 
;       (city (name ?city3) (cities-from-0-to-29 $?cities0-29&:(member ?city1 $?cities0-29)))
;     )
;     (and
;       (cf-cities-from-30-to-59 ?cf-distance) 
;       (city (name ?city3) (cities-from-30-to-59 $?cities30-59&:(member ?city1 $?cities30-59)))
;     )
;     (and
;       (cf-cities-from-60-to-89 ?cf-distance)
;       (city (name ?city3) (cities-from-60-to-89 $?cities60-89&:(member ?city1 $?cities60-89))) 
;     )
;     (and 
;       (cf-cities-from-90-to-120 ?cf-distance)
;       (city (name ?city3) (cities-from-90-to-120 $?cities90-120&:(member ?city1 $?cities90-120)))
;     )
;   )

;   (or 
;     (and
;       (cf-cities-from-0-to-29 ?cf-distance) 
;       (city (name ?city3) (cities-from-0-to-29 $?cities0-29&:(member ?city2 $?cities0-29)))
;     )
;     (and
;       (cf-cities-from-30-to-59 ?cf-distance) 
;       (city (name ?city3) (cities-from-30-to-59 $?cities30-59&:(member ?city2 $?cities30-59)))
;     )
;     (and
;       (cf-cities-from-60-to-89 ?cf-distance)
;       (city (name ?city3) (cities-from-60-to-89 $?cities60-89&:(member ?city2 $?cities60-89))) 
;     )
;     (and 
;       (cf-cities-from-90-to-120 ?cf-distance)
;       (city (name ?city3) (cities-from-90-to-120 $?cities90-120&:(member ?city2 $?cities90-120)))
;     )
;   )
;   )

;   =>
;   (assert (three-places-solution ?name1 ?name2 ?name3 ?city1 ?city2 ?city3 (* (+ ?cf-2-places ?cf3) ?cf-distance)))
; )

; (defrule GENERATE-SOLUTIONS::delete-redundanct-facts
;   ?sol2 <- (three-places-solution ?name1 ?name2 ?name3 $?cities ?cf1)
;   (or
;     ?sol <- (three-places-solution ?name1 ?name2 ?name3 $?cities ?cf2&:(neq ?cf1 ?cf2)) 
;     ?sol <- (three-places-solution ?name2 ?name1 ?name3 $?cities1 ?cf2)
;     ?sol <- (three-places-solution ?name1 ?name3 ?name2 $?cities1 ?cf2)
;     ?sol <- (three-places-solution ?name2 ?name3 ?name1 $?cities1 ?cf2)
;     ?sol <- (three-places-solution ?name3 ?name2 ?name1 $?cities1 ?cf2)
;     ?sol <- (three-places-solution ?name3 ?name1 ?name2 $?cities1 ?cf2)
;   )
;   =>
;   (retract ?sol ?sol2)
;   (assert (three-places-solution ?name1 ?name2 ?name3 $?cities (max ?cf1 ?cf2)))
; )

;****************************************************************************
;****************************************************************************
;****************************** end multilocalita ***************************
;****************************************************************************
;****************************************************************************

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
