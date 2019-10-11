;;****************
;;*  EXPERTISE   *
;;****************
(defmodule EXPERTISE (import MAIN ?ALL))

(deftemplate EXPERTISE::inference
  (slot attribute)
  (slot value)
  (multislot expertise)
)

(deffacts EXPERTISE::expertise-knowledge
  ; ----- Region -----
  (inference (attribute region) (value liguria) (expertise
    turism [ sea 0.8 mountain 0.3 enogastronomic 0.5 lake -0.9 termal -0.5 sport 0.5 naturalistic 0.6 ]
    region [ piemonte 0.1 toscana 0.6 valle-d'aosta -0.6 trentino-alto-adige -0.8 veneto 0.2 emilia-romagna 0.2 umbria -0.7 marche 0.3 ] ))
  (inference (attribute region) (value piemonte) (expertise
    turism [ sea -0.9 mountain 0.9 enogastronomic 0.7 lake 0.5 termal 0.2 religious 0.4 cultural 0.4 ]
    region [ liguria 0.1 toscana -0.5 lombardia 0.5 valle-d'aosta 0.7 trentino-alto-adige 0.4 umbria -0.1 marche -0.8 ] ))
  ; ----- Turism -----
  (inference (attribute turism) (value sea) (expertise
    region [ piemonte -0.8 liguria 0.8 toscana 0.7 lombardia -0.8 valle-d'aosta -0.9 trentino-alto-adige -0.9 veneto 0.7 emilia-romagna 0.9 umbria -0.6 marche 0.4 friuli-venezia-giulia 0.3 ]
    turism [ mountain -0.8 lake 0.6 ] ))
  (inference (attribute turism) (value mountain) (expertise
    region [ piemonte 0.7 liguria -0.2 toscana -0.3 lombardia 0.4 valle-d'aosta 0.9 trentino-alto-adige 0.9 emilia-romagna -0.9  marche -0.6 friuli-venezia-giulia 0.2 ]
    turism [ sea -0.8 lake 0.4 termal 0.2 naturalistic 0.5 ] ))
  (inference (attribute turism) (value enogastronomic) (expertise
    region [ piemonte 0.5 liguria 0.5 toscana 0.7 valle-d'aosta 0.2 trentino-alto-adige 0.2 veneto 0.4 emilia-romagna 0.8 umbria 0.5 ]
    turism [ ] ))
  (inference (attribute turism) (value sport) (expertise
    region [ liguria 0.2 lombardia -0.2 valle-d'aosta 0.6 trentino-alto-adige 0.6 emilia-romagna 0.3 marche 0.2 friuli-venezia-giulia 0.3 ]
    turism [ mountain 0.5 lake 0.3 sea 0.4 ] ))
  (inference (attribute turism) (value lake) (expertise
    region [ piemonte 0.5 liguria -0.8 toscana -0.7 lombardia 0.8 valle-d'aosta -0.2 trentino-alto-adige 0.5 veneto 0.2 umbria 0.3 marche -0.6 ]
    turism [ sea 0.6 naturalistic 0.5 ] ))
  (inference (attribute turism) (value naturalistic) (expertise
    region [ piemonte 0.5 liguria 0.4 toscana 0.2 valle-d'aosta 0.7 trentino-alto-adige 0.8 veneto -0.3 emilia-romagna -0.6 marche -0.1 friuli-venezia-giulia 0.3 ]
    turism [ mountain 0.5 lake 0.5 ] ))
  (inference (attribute turism) (value cultural) (expertise
    region [ piemonte 0.4 liguria -0.4 toscana 0.9 lombardia 0.5 trentino-alto-adige -0.6 veneto 0.6 umbria 0.8 friuli-venezia-giulia 0.3 ]
    turism [ religious 0.5 ] ))
  (inference (attribute turism) (value termal) (expertise
    region [ liguria -0.5 toscana 0.6 lombardia 0.5 valle-d'aosta 0.2 trentino-alto-adige 0.7 emilia-romagna -0.4 ]
    turism [ mountain 0.2 ] ))
  (inference (attribute turism) (value religious) (expertise
    region [ piemonte 0.5 liguria -0.3 toscana 0.4 lombardia 0.2 trentino-alto-adige -0.5 umbria 0.8 marche 0.6 ]
    turism [ cultural 0.5 ] ))
  (inference-from-old-age enogastronomic religious cultural )
)

(defrule EXPERTISE::convert-optional-user-attribute ;TODO spostare nel main??
  (user-attribute
    (name ?name)
    (values $? ?value $?)
    (type optional)
  )
  =>
  (assert (attribute (name ?name) (value ?value)))
)

(defrule EXPERTISE::expertise-rule
  (user-attribute (name ?user-attribute) (values $? ?value $?))
  (inference (attribute ?user-attribute) (value ?value) (expertise $?prev ?attribute [ $?values&:(not (member ] ?values)) ] $?next))
  =>
  (assert (new-attributes ?attribute $?values)) ;; TODO Fare template con new-attributes???
)

(defrule EXPERTISE::create-expertise-attribute
  (new-attributes ?attribute $?prev ?value ?cf&:(eq (type ?cf) FLOAT) $?next)
  =>
  (assert (attribute (name ?attribute) (value ?value) (certainty ?cf)))
)

(defrule EXPERTISE::create-not-find-expertise-attribute
  (new-attributes ?attribute $?values)
  (parameter (name ?attribute) (values $?prev ?value&:(not (member ?value ?values)) $?next))
  =>
  (assert (attribute (name ?attribute) (value ?value) (certainty 0.0)))
)
;(values $?turisms&:(not (member ?inference-attribute $?turisms))))
; (defrule EXPERTISE::infer-turism-from-age
;   (user-attribute (name turism) (values $?turisms))
;   (inference-from-old-age $? ?inference-attribute&:(not (member ?inference-attribute $?turisms)) $?)
;   (user-attribute (name age) (values ?age&:(>= ?age 60) $?) (type profile))
;   =>
;   (assert (attribute (name turism) (value ?inference-attribute) (certainty 0.5)))
; )
