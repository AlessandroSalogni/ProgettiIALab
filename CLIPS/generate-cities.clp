(defmodule GENERATE-CITIES (import MAIN ?ALL))

(deftemplate GENERATE-CITIES::city
  (slot name (type STRING))
  (slot region)
  (multislot coordinates (type FLOAT) (cardinality 2 2))
  (multislot turism)
)

(deffacts GENERATE-CITIES::city-definition
  (city (name "Assisi") (region umbria) (coordinates 2.0 3.0) (turism mountain 2 cultural 5 enogastronomic 4 naturalistic 1 religious 5))
  (city (name "Milano") (region lombardia) (coordinates 2.0 3.0) (turism cultural 4 sport 1 enogastronomic 1 religious 2))
  (city (name "Desenzano del Garda") (region lombardia) (coordinates 2.0 3.0) (turism sport 2 lake 5 enogastronomic 1 naturalistic 3))
  (city (name "Como") (region lombardia) (coordinates 2.0 3.0) (turism mountain 2 cultural 1 sport 1 lake 4 enogastronomic 1 naturalistic 2 ))
  (city (name "Firenze") (region toscana) (coordinates 2.0 3.0) (turism cultural 5 enogastronomic 4 religious 3))
  (city (name "Siena") (region toscana) (coordinates 2.0 3.0) (turism cultural 4 termal 4 enogastronomic 4 religious 1))
  (city (name "Pisa") (region toscana) (coordinates 2.0 3.0) (turism sea 3 cultural 3 enogastronomic 3 religious 1))
  (city (name "Massa") (region toscana) (coordinates 2.0 3.0) (turism sea 4 sport 1 enogastronomic 3))
  (city (name "Savona") (region liguria) (coordinates 4.0 80.0) (turism sea 5 mountain 1 sport 2 enogastronomic 2 naturalistic 1))
  (city (name "Imperia") (region liguria) (coordinates 2.0 80.0) (turism sea 4 mountain 1 sport 2 enogastronomic 2 naturalistic 2))
  (city (name "Genova") (region liguria) (coordinates 6.0 80.0) (turism sea 4 mountain 1 sport 2 enogastronomic 3 naturalistic 1))
  (city (name "Celle Ligure") (region liguria) (coordinates 2.0 3.0) (turism sea 5 sport 2 enogastronomic 2 naturalistic 2))
  (city (name "Sestri Levante") (region liguria) (coordinates 2.0 3.0) (turism sea 5 sport 2 enogastronomic 2 naturalistic 2))
  (city (name "Torino") (region piemonte) (coordinates 6.0 80.0) (turism mountain 3 cultural 4 sport 1 enogastronomic 3 naturalistic 2 religious 2))
  (city (name "Biella") (region piemonte) (coordinates 6.0 80.0) (turism mountain 4 cultural 1 sport 2 enogastronomic 3 naturalistic 3 religious 5))
  (city (name "Verbania") (region piemonte) (coordinates 2.0 3.0) (turism mountain 5 sport 3 lake 5 termal 1 enogastronomic 3 naturalistic 4))
  (city (name "Cuneo") (region piemonte) (coordinates 2.0 3.0) (turism mountain 5 sport 2 termal 1 enogastronomic 3 naturalistic 4))
  (city (name "Verona") (region veneto) (coordinates 6.0 80.0) (turism mountain 1 cultural 4 sport 1 lake 5 enogastronomic 2 naturalistic 3))
  (city (name "Venezia") (region veneto) (coordinates 2.0 3.0) (turism sea 3 cultural 5 sport 1 enogastronomic 3 naturalistic 2 religious 2))
  (city (name "Padova") (region veneto) (coordinates 2.0 3.0) (turism mountain 1 cultural 5 enogastronomic 1 religious 4))
  (city (name "Gorizia") (region friuli-venezia-giulia) (coordinates 2.0 3.0) (turism sea 1 mountain 2 cultural 2 lake 1 enogastronomic 1 naturalistic 2))
  (city (name "Trieste") (region friuli-venezia-giulia) (coordinates 2.0 3.0) (turism sea 2 cultural 2 sport 2 enogastronomic 1 naturalistic 2))
  (city (name "Bolzano") (region trentino-alto-adige) (coordinates 2.0 3.0) (turism mountain 5 sport 4 lake 3 termal 2 enogastronomic 3 naturalistic 3))
  (city (name "Trento") (region trentino-alto-adige) (coordinates 2.0 3.0) (turism mountain 5 sport 4 lake 2 termal 2 enogastronomic 3 naturalistic 3))
  (city (name "Bologna") (region emilia-romagna) (coordinates 2.0 3.0) (turism cultural 3 enogastronomic 5 naturalistic 1))
  (city (name "Ravenna") (region emilia-romagna) (coordinates 2.0 3.0) (turism sea 5 cultural 1 sport 2 enogastronomic 4 naturalistic 2))
  (city (name "Ferrara") (region emilia-romagna) (coordinates 2.0 3.0) (turism cultural 2 lake 5 enogastronomic 3 naturalistic 2))
  (city (name "Aosta") (region valle-d'aosta) (coordinates 2.0 3.0) (turism mountain 5 cultural 1 sport 4 lake 1 termal 3 enogastronomic 2 naturalistic 4))
  (city (name "Saint Vincent") (region valle-d'aosta) (coordinates 2.0 3.0) (turism mountain 5 sport 1 termal 5 enogastronomic 1 naturalistic 4))
)

(defrule GENERATE-CITIES:generate-city-from-turism
  (parameter (name turism) (values $? ?turism $?))
  (or
    (and
      (attribute (name turism) (value ?turism) (certainty ?cf-turism))
      (city (name ?city) (turism $? ?turism ?score $?))
    )
    (and
      (not (attribute (name turism) (value ?turism)))
      (city (name ?city) (turism $? ?turism ?score $?))
      (bind ?cf-turism 0) 
    )
    (and
      (attribute (name turism) (value ?turism) (certainty ?cf-turism))
      (city (name ?city) (turism $?turisms&:(not (member ?turism ?turisms))))
      (bind ?score 0) 
    )
    (and
      (not (attribute (name turism) (value ?turism)))
      (city (name ?city) (turism $?turisms&:(not (member ?turism ?turisms))))
      (bind ?cf-turism 0) 
      (bind ?score 0) 
    )
  )
  =>
  (bind ?cf-score (- (/ (* ?score 1.98) 5) 0.99))
  (assert (attribute (name city) (value ?city) (certainty (* ?cf-turism ?cf-score))))
)

(defrule GENERATE-CITIES::generate-city-from-region
  (attribute (name region) (value ?region) (certainty ?cf-region))
  (city (name ?city) (region ?region))
  =>
  (assert (attribute (name city) (value ?city) (certainty ?cf-region)))
)