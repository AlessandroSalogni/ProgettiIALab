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
  (slot certainty (type FLOAT))
  (slot min-cf-incremental-solution (type FLOAT))
  (multislot sum-cf-distance-incremental-solution (type FLOAT) (default 0.0))
  (slot number-places (type INTEGER))
)

(defrule GENERATE-SOLUTIONS::start (declare (salience 10000))
  (iteration ?i)
  =>
  (assert (counter 5))
  (focus GENERATE-CITIES GENERATE-FACILITIES RETRACT-FACILITIES OPERATIONS-ON-FACILITIES)
)

(defrule GENERATE-SOLUTIONS::find-5-solutions (declare (salience -100))
  (iteration ?i)
  ?counter <- (counter ?counter-value&:(> ?counter-value 0))
  (user-attribute (name number-places) (values ?user-number-places))
  ?selected-solution <- 
  (solution 
    (facilities $?selected-facilities) (cities $?selected-cities) (certainty ?cf-max)
    (number-places ?selected-number-places&:(or(eq ?user-number-places ?selected-number-places) (eq ?selected-number-places (- ?user-number-places 1))))
  )
  (not 
    (solution (facilities $?facilities) (cities $?cities) (certainty ?cf&:(> ?cf ?cf-max)) 
      (number-places ?number-places&:(or(eq ?user-number-places ?number-places) (eq ?number-places (- ?user-number-places 1))))
    )
  )
  =>
  (assert 
    (final-solution $?selected-facilities ?cf-max)
  )  
  (retract ?counter ?selected-solution)
  (assert (counter (- ?counter-value 1)))
)

(defrule GENERATE-SOLUTIONS::generate-one-places-solutions
  (iteration ?i)

  (attribute (name facility) (value ?facility) (certainty ?cf) (iteration ?i))
  (facility (name ?facility) (city ?city))
  =>
  (assert (solution (facilities ?facility) (cities ?city) (certainty ?cf) (min-cf-incremental-solution ?cf) (number-places 1)))
)

(defrule GENERATE-SOLUTIONS::generate-n-places-solutions
  (iteration ?i)
  (user-attribute (name number-places) (values ?n-max))

  (near-cities (city1 ?city) (city2 ?city-near) (distance-range ?distance-range))
  (cf-distance ?distance-range ?cf-distance)

  (solution (facilities ?facility1) (cities ?city1&:(or (eq ?city1 ?city) (eq ?city1 ?city-near))) (certainty ?cf1) (number-places 1))   
  (solution (facilities $?facilities2) (cities $?cities2&:(not (member ?city1 ?cities2))&:(or (member ?city ?cities2) (member ?city-near ?cities2)))
    (min-cf-incremental-solution ?cf-min2) (sum-cf-distance-incremental-solution ?cf-sum-distance2) (number-places ?n2&:(< ?n2 ?n-max))) 
  =>
  (bind ?min-cf (min ?cf1 ?cf-min2))
  (bind ?mean-cf-distance (/ (+ ?cf-distance ?cf-sum-distance2) ?n2))
  (bind ?cf (- (+ ?min-cf ?mean-cf-distance) (* ?min-cf ?mean-cf-distance)))
  (assert (solution (facilities ?facilities2 ?facility1) (cities ?cities2 ?city1) (certainty ?cf) (min-cf-incremental-solution ?min-cf)
    (sum-cf-distance-incremental-solution (+ ?cf-distance ?cf-sum-distance2)) (number-places (+ 1 ?n2)))) 
)

(defrule GENERATE-SOLUTIONS::sort-cities-in-solution
  ?sol <- (solution (cities $?head ?city-next ?city&:(< (str-compare ?city ?city-next) 0) $?tail))
  =>
  (modify ?sol (cities ?head ?city ?city-next ?tail))
)

(defrule GENERATE-SOLUTIONS::retract-solutions-with-same-cities
  ?sol1 <- (solution (cities $?cities) (certainty ?cf1) (number-places ?n))
  ?sol2 <- (solution (cities $?cities) (certainty ?cf2&:(<= ?cf2 ?cf1)) (number-places ?n))
  (test (neq ?sol1 ?sol2))
  =>
  (retract ?sol2)
)

(defrule GENERATE-SOLUTIONS::end (declare (salience -10000))
  (iteration ?i)
  ?counter <- (counter ?x)
  =>
  (retract ?counter)
  (focus GENERATE-CITIES GENERATE-FACILITIES)
)
