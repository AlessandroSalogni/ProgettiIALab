(defmodule CONTRADICTORY-RESOLUTION (import MAIN ?ALL)
  (deftemplate CONTRADICTORY-RESOLUTION::contradictory-fact
    (slot attribute-name)
    (slot attribute-value)
  )

  (defrule CONTRADICTORY-RESOLUTION::contradictory-resolution-rule
    ?contradictory-fact <- (contradictory-fact (attribute-name ?name) (attribute-value ?value))
    (bind ?question (str-cat ?name ?value ": y/n?"))
    =>
    (assert 
      (contradictory-resolution-question 
        (name ?name) 
        (value ?value) 
        (question ?question)
      )
    )
    (focus USER-INTERACTION)
  ) 
)