;;****************
;;*  EXPERTISE   *
;;****************
(defmodule EXPERTISE (import MAIN ?ALL))

; (deftemplate EXPERTISE::expertise-from-age
;   (slot attribute)
;   (multislot age-range (cardinality 2 2) (type INTEGER))
;   (multislot expertise)
; )

(deftemplate EXPERTISE::expertise-from-attribute
  (slot attribute)
  (slot value)
  (multislot expertise)
)

(deffacts EXPERTISE::expertise-knowledge
  ; ----- Region -----
  (expertise-from-attribute (attribute region) (value liguria) (expertise
    turism [ sea 0.8 mountain 0.2 enogastronomic 0.5 lake -0.8 termal -0.5 sport 0.5 naturalistic 0.5 ]
    region [ piemonte 0.2 toscana 0.5 valle-d'aosta -0.5 trentino-alto-adige -0.8 veneto 0.2 emilia-romagna 0.2 umbria -0.8 marche 0.2 ] ))
  (expertise-from-attribute (attribute region) (value piemonte) (expertise
    turism [ sea -0.8 mountain 0.8 enogastronomic 0.8 lake 0.5 termal 0.2 religious 0.5 cultural 0.5 ]
    region [ liguria 0.2 toscana -0.5 lombardia 0.5 valle-d'aosta 0.8 trentino-alto-adige 0.5 umbria -0.2 marche -0.8 ] ))
  ; ----- Turism -----
  (expertise-from-attribute (attribute turism) (value sea) (expertise
    region [ piemonte -0.8 liguria 0.8 toscana 0.8 lombardia -0.8 valle-d'aosta -0.8 trentino-alto-adige -0.8 veneto 0.8 emilia-romagna 0.8 umbria -0.5 marche 0.5 friuli-venezia-giulia 0.2 ]
    turism [ mountain -0.8 lake 0.5 ] ))
  (expertise-from-attribute (attribute turism) (value mountain) (expertise
    region [ piemonte 0.8 liguria -0.2 toscana -0.2 lombardia 0.5 valle-d'aosta 0.8 trentino-alto-adige 0.8 emilia-romagna -0.8  marche -0.5 friuli-venezia-giulia 0.2 ]
    turism [ sea -0.8 lake 0.5 termal 0.2 naturalistic 0.5 ] ))
  (expertise-from-attribute (attribute turism) (value enogastronomic) (expertise
    region [ piemonte 0.5 liguria 0.5 toscana 0.8 valle-d'aosta 0.2 trentino-alto-adige 0.2 veneto 0.5 emilia-romagna 0.8 umbria 0.5 ]
    turism [ ] ))
  (expertise-from-attribute (attribute turism) (value sport) (expertise
    region [ liguria 0.2 lombardia -0.2 valle-d'aosta 0.5 trentino-alto-adige 0.5 emilia-romagna 0.2 marche 0.2 friuli-venezia-giulia 0.2 ]
    turism [ mountain 0.5 lake 0.2 sea 0.5 ] ))
  (expertise-from-attribute (attribute turism) (value lake) (expertise
    region [ piemonte 0.5 liguria -0.8 toscana -0.8 lombardia 0.8 valle-d'aosta -0.2 trentino-alto-adige 0.5 veneto 0.2 umbria 0.2 marche -0.5 ]
    turism [ sea 0.5 naturalistic 0.5 ] ))
  (expertise-from-attribute (attribute turism) (value naturalistic) (expertise
    region [ piemonte 0.5 liguria 0.5 toscana 0.2 valle-d'aosta 0.8 trentino-alto-adige 0.8 veneto -0.2 emilia-romagna -0.5 marche -0.2 friuli-venezia-giulia 0.2 ]
    turism [ mountain 0.5 lake 0.5 ] ))
  (expertise-from-attribute (attribute turism) (value cultural) (expertise
    region [ piemonte 0.5 liguria -0.5 toscana 0.8 lombardia 0.5 trentino-alto-adige -0.5 veneto 0.5 umbria 0.8 friuli-venezia-giulia 0.2 ]
    turism [ religious 0.5 ] ))
  (expertise-from-attribute (attribute turism) (value termal) (expertise
    region [ liguria -0.5 toscana 0.5 lombardia 0.5 valle-d'aosta 0.2 trentino-alto-adige 0.8 emilia-romagna -0.5 ]
    turism [ mountain 0.2 ] ))
  (expertise-from-attribute (attribute turism) (value religious) (expertise
    region [ piemonte 0.5 liguria -0.2 toscana 0.5 lombardia 0.2 trentino-alto-adige -0.5 umbria 0.8 marche 0.5 ]
    turism [ cultural 0.5 ] ))

  (expertise-from-attribute (attribute age-class) (value young) (expertise 
    turism [ sport 0.5 sea 0.5 religious -0.5 ]))  
  (expertise-from-attribute (attribute age-class) (value middle-young) (expertise 
    turism [ cultural 0.5 enogastronomic 0.5 ]))  
  (expertise-from-attribute (attribute age-class) (value middle-old) (expertise 
    turism [ cultural 0.5 enogastronomic 0.5 mountain 0.5 ]))  
  (expertise-from-attribute (attribute age-class) (value old) (expertise 
    turism [ cultural 0.5 religious 0.5 sport -0.5 termal 0.5 ]))
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
  ; (or
  (expertise-from-attribute (attribute ?user-attribute) (value ?value)
  (expertise $? ?attribute [ $?values&:(not (member ] ?values)) ] $?))  
    ; (expertise-from-age (attribute ?user-attribute) (age-range ?min&:(<= ?min ?value) ?max&:(<= ?value ?max)) 
    ;   (expertise $? ?attribute [ $?values&:(not (member ] ?values)) ] $?))
  ;)
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

(defrule EXPERTISE::expertise-from-live-region
  (user-attribute (name live-region) (values ?region))
  =>
  (assert (attribute (name region) (value ?region) (certainty -0.5)))
)