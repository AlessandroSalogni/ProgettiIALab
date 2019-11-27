(defmodule GENERATE-SOLUTIONS (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL) (import GENERATE-CITIES ?ALL) (export ?ALL))

(deftemplate GENERATE-SOLUTIONS::possible-solution
  (multislot facilities (type STRING))
  (multislot cities (type STRING))
  (slot certainty (type FLOAT))
  (slot min-cf-incremental-solution (type FLOAT))
  (slot sum-cf-distance-incremental-solution (type FLOAT) (default 0.0))
  (slot number-places (type INTEGER))
)

(defrule GENERATE-SOLUTIONS::generate-one-place-solution
  (iteration ?i)

  (attribute (name facility) (value ?facility) (certainty ?cf) (iteration ?i))
  (facility (name ?facility) (city ?city))
  =>
  (assert (possible-solution (facilities ?facility) (cities ?city) (certainty ?cf) (min-cf-incremental-solution ?cf) (number-places 1)))
)

(defrule GENERATE-SOLUTIONS::generate-n-places-solution
  (iteration ?i)
  (user-attribute (name number-places) (values ?n-max))

  (near-cities (city1 ?city) (city2 ?city-near) (distance-range ?distance-range))
  (cf-distance ?distance-range ?cf-distance)

  (possible-solution (facilities ?facility1) (cities ?city1&:(or (eq ?city1 ?city) (eq ?city1 ?city-near))) (certainty ?cf1) (number-places 1))   
  (possible-solution (facilities $?facilities2) (cities $?cities2&:(not (member ?city1 ?cities2))&:(or (member ?city ?cities2) (member ?city-near ?cities2)))
    (min-cf-incremental-solution ?cf-min2) (sum-cf-distance-incremental-solution ?cf-sum-distance2) (number-places ?n2&:(< ?n2 ?n-max))) 
  =>
  (bind ?min-cf (min ?cf1 ?cf-min2))
  (bind ?mean-cf-distance (/ (+ ?cf-distance ?cf-sum-distance2) ?n2))
  (bind ?cf (- (+ ?min-cf ?mean-cf-distance) (* ?min-cf ?mean-cf-distance)))
  (assert (possible-solution (facilities ?facilities2 ?facility1) (cities ?cities2 ?city1) (certainty ?cf) (min-cf-incremental-solution ?min-cf)
    (sum-cf-distance-incremental-solution (+ ?cf-distance ?cf-sum-distance2)) (number-places (+ 1 ?n2)))) 
)

(defrule GENERATE-SOLUTIONS::sort-cities-in-solution
  ?sol <- (possible-solution (cities $?head ?city-next ?city&:(< (str-compare ?city ?city-next) 0) $?tail))
  =>
  (modify ?sol (cities ?head ?city ?city-next ?tail))
)

(defrule GENERATE-SOLUTIONS::retract-solutions-with-same-cities 
  ?sol1 <- (possible-solution (cities $?cities) (certainty ?cf1) (number-places ?n))
  ?sol2 <- (possible-solution (cities $?cities) (certainty ?cf2&:(<= ?cf2 ?cf1)) (number-places ?n))
  (test (neq ?sol1 ?sol2))
  =>
  (retract ?sol2)
)