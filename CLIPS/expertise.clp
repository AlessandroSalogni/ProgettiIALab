;;****************
;;*  EXPERTISE   *
;;****************
(defmodule EXPERTISE (import MAIN ?ALL))

(deftemplate EXPERTISE::inference
  (slot attribute)
  (slot value)
  (multislot expertise)
)

(deftemplate EXPERTISE::expertise-attribute
  (slot name)
  (slot value)
  (slot certainty (type FLOAT) (default 0.99) (range -0.99 0.99))
  (multislot created-by (cardinality 2 2))
)

(deffacts EXPERTISE::expertise-knowledge
  (inference (attribute region) (value liguria) (expertise turism [ sea 0.8 mountain 0.3 enogastronomic 0.5 lake -0.9 termal -0.5
    sport 0.5 naturalistic 0.6 religious 0.0 cultural 0.0 ] region [ piemonte 0.1 toscana 0.6 lombardia 0.0 valle-d'aosta -0.6
    trentino-alto-adige -0.8 veneto 0.2 emilia-romagna 0.2 umbria -0.7 marche 0.3 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute region) (value piemonte) (expertise turism [ sea -0.9 mountain 0.9 enogastronomic 0.7 lake 0.5 termal 0.2
    sport 0.0 naturalistic 0.0 religious 0.4 cultural 0.4 ] region [ liguria 0.1 toscana -0.5 lombardia 0.5 valle-d'aosta 0.7
    trentino-alto-adige 0.4 veneto 0.0 emilia-romagna 0.0 umbria -0.1 marche -0.8 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value sea) (expertise region [ piemonte -0.8 liguria 0.8 toscana 0.7 lombardia -0.8 valle-d'aosta -0.9
    trentino-alto-adige -0.9 veneto 0.7 emilia-romagna 0.9 umbria -0.6 marche 0.4 friuli-venezia-giulia 0.3 ]))
  (inference (attribute turism) (value mountain) (expertise region [ piemonte 0.7 liguria -0.2 toscana -0.3 lombardia 0.4 valle-d'aosta 0.9
    trentino-alto-adige 0.9 veneto 0.0 emilia-romagna -0.9 umbria 0.0 marche -0.6 friuli-venezia-giulia 0.2 ] ))
  (inference (attribute turism) (value enogastronomic) (expertise region [ piemonte 0.5 liguria 0.5 toscana 0.7 lombardia 0.0 valle-d'aosta 0.2
    trentino-alto-adige 0.2 veneto 0.4 emilia-romagna 0.8 umbria 0.5 marche 0.0 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value sport) (expertise region [ piemonte 0.0 liguria 0.2 toscana 0.0 lombardia -0.2 valle-d'aosta 0.6
    trentino-alto-adige 0.6 veneto 0.0 emilia-romagna 0.3 umbria 0.0 marche 0.2 friuli-venezia-giulia 0.3 ] ))
  (inference (attribute turism) (value lake) (expertise region [ piemonte 0.5 liguria -0.8 toscana -0.7 lombardia 0.8 valle-d'aosta -0.2
    trentino-alto-adige 0.5 veneto 0.2 emilia-romagna 0.0 umbria 0.3 marche -0.6 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value naturalistic) (expertise region [ piemonte 0.5 liguria 0.4 toscana 0.2 lombardia 0.0 valle-d'aosta 0.7
    trentino-alto-adige 0.8 veneto -0.3 emilia-romagna -0.6 umbria 0.0 marche -0.1 friuli-venezia-giulia 0.3 ] ))
  (inference (attribute turism) (value cultural) (expertise region [ piemonte 0.4 liguria -0.4 toscana 0.9 lombardia 0.5 valle-d'aosta 0.0
    trentino-alto-adige -0.6 veneto 0.6 emilia-romagna 0.0 umbria 0.8 marche 0.0 friuli-venezia-giulia 0.3 ] ))
  (inference (attribute turism) (value termal) (expertise region [ piemonte 0.0 liguria -0.5 toscana 0.6 lombardia 0.5 valle-d'aosta 0.2
    trentino-alto-adige 0.7 veneto 0.0 emilia-romagna -0.4 umbria 0.0 marche 0.0 friuli-venezia-giulia 0.0 ] ))
  (inference (attribute turism) (value religious) (expertise region [ piemonte 0.5 liguria -0.3 toscana 0.4 lombardia 0.2 valle-d'aosta 0.0
    trentino-alto-adige -0.5 veneto 0.0 emilia-romagna 0.0 umbria 0.8 marche 0.6 friuli-venezia-giulia 0.0 ] ))
)

(defrule EXPERTISE::expertise-rule
  (attribute (name ?user-attribute) (value ?value) (type user))
  (inference (attribute ?user-attribute) (value ?value) (expertise $?prev ?attribute [ $?values&:(not (member ] ?values)) ] $?next))
  =>
  (assert (new-attributes ?user-attribute ?value ?attribute $?values))
)

(defrule EXPERTISE::create-expertise-attribute
  ?fact <- (new-attributes ?from-attribute ?from-value ?attribute ?value ?cf $?next)
  =>
  (retract ?fact)
  (assert (new-attributes ?from-attribute ?from-value ?attribute $?next))
  (assert (expertise-attribute (name ?attribute) (value ?value) (certainty ?cf) (created-by ?from-attribute ?from-value)))
)

(defrule EXPERTISE::remove-empty-new-attributes
  ?fact <- (new-attributes ?from-attribute ?from-value ?attribute)
  =>
  (retract ?fact)
)

(defrule EXPERTISE::pattern-or-from-expertise-to-system
  (attribute-pattern (name ?from-attribute) (values ?from-value1 ?from-value2) (conjunction or) (id ?id))
  ?attr1 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf1) (created-by ?from-attribute ?from-value1))
  ?attr2 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf2) (created-by ?from-attribute ?from-value2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (max ?cf1 ?cf2)) (created-by ?from-attribute ?id))
)

(defrule EXPERTISE::pattern-and-turism-from-expertise-to-system
  (attribute-pattern (name turism) (values ?from-value1 ?from-value2) (conjunction and) (id ?id))
  ?attr1 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf1) (created-by turism ?from-value1))
  ?attr2 <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf2) (created-by turism ?from-value2))
  =>
  (retract ?attr1)
  (modify ?attr2 (certainty (min ?cf1 ?cf2)) (created-by turism ?id))
  (assert (attribute (name different-region) (value 1))) ; TODO valutare certezza
)

(defrule EXPERTISE::pattern-none-from-expertise-to-system
  (attribute-pattern (name ?from-attribute) (values ?from-value) (conjunction none))
  ?attr <- (expertise-attribute (name ?name) (value ?value) (certainty ?cf) (created-by ?from-attribute ?from-value))
  =>
  (retract ?attr)
  (assert (attribute (name ?name) (value ?value) (certainty ?cf)))
)
