(defmodule RETRACT-FACILITIES (import MAIN ?ALL) (import GENERATE-FACILITIES ?ALL) (import ITERATION-MANAGER ?ALL))

(defrule RETRACT-FACILITIES::retract-facilities-base-on-city
  (iteration ?i)
  ?attr <- (attribute (name facility) (value ?name) (iteration ?i))
  (facility (name ?name) (city ?city))
  (attribute (name city) (value ?city) (certainty ?cf&:(<= ?cf -0.4)) (iteration ?i))
  =>
  (retract ?attr)
)

(defrule RETRACT-FACILITIES::retract-facilities-base-on-cf
  (iteration ?i)
  ?attr <- (attribute (name facility) (value ?name) (certainty ?cf&:(< ?cf 0.4)) (iteration ?i))
  =>
  (retract ?attr)
)

(defrule RETRACT-FACILITIES::retract-facilities-base-on-availability
  (iteration ?i)
  ?attr <- (attribute (name facility) (value ?name) (iteration ?i))
  (facility (name ?name) (rooms-available ?rooms))
  (user-attribute (name number-people) (values ?number-people&:(> ?number-people (* ?rooms 2))))
  =>
  (retract ?attr)
)