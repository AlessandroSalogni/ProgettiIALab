;;****************
;;*  EXPERTISE   *
;;****************
(defmodule EXPERTISE (import MAIN ?ALL))

(deftemplate EXPERTISE::expertise
  (slot user-attribute)
  (slot value)
  (slot type (allowed-symbols mandatory optional profile) (default optional))
  (multislot inference)
)

(deftemplate EXPERTISE::new-attributes
  (slot attribute)
  (multislot values)
  (slot deviation (type FLOAT) (range 0.0 1.0) (default 0.0))
)

(deffacts EXPERTISE::expertise-knowledge
  ; ----- Region -----
  (expertise (user-attribute region) (value liguria) (inference
    turism [ sea 0.8 mountain 0.2 enogastronomic 0.5 lake -0.8 termal -0.5 sport 0.5 naturalistic 0.5 ]
    region [ piemonte 0.2 toscana 0.5 valle-d'aosta -0.5 trentino-alto-adige -0.8 veneto 0.2 emilia-romagna 0.2 umbria -0.8 marche 0.2 ] ))
  (expertise (user-attribute region) (value piemonte) (inference
    turism [ sea -0.8 mountain 0.8 enogastronomic 0.8 lake 0.5 termal 0.2 religious 0.5 cultural 0.5 ]
    region [ liguria 0.2 toscana -0.5 lombardia 0.5 valle-d'aosta 0.8 trentino-alto-adige 0.5 umbria -0.2 marche -0.8 ] ))
  ; ----- Turism -----
  (expertise (user-attribute turism) (value sea) (inference
    region [ piemonte -0.8 liguria 0.8 toscana 0.8 lombardia -0.8 valle-d'aosta -0.8 trentino-alto-adige -0.8 veneto 0.5 emilia-romagna 0.8 umbria -0.5 marche 0.5 friuli-venezia-giulia 0.2 ]
    turism [ mountain -0.8 lake 0.5 ] ))
  (expertise (user-attribute turism) (value mountain) (inference
    region [ piemonte 0.8 liguria -0.2 toscana -0.2 lombardia 0.5 valle-d'aosta 0.8 trentino-alto-adige 0.8 emilia-romagna -0.8  marche -0.5 friuli-venezia-giulia 0.2 ]
    turism [ sea -0.8 lake 0.5 termal 0.2 naturalistic 0.5 ] ))
  (expertise (user-attribute turism) (value enogastronomic) (inference
    region [ piemonte 0.5 liguria 0.5 toscana 0.8 valle-d'aosta 0.2 trentino-alto-adige 0.2 veneto 0.5 emilia-romagna 0.8 umbria 0.5 ]
    turism [ ] ))
  (expertise (user-attribute turism) (value sport) (inference
    region [ liguria 0.2 lombardia -0.2 valle-d'aosta 0.5 trentino-alto-adige 0.5 emilia-romagna 0.2 marche 0.2 friuli-venezia-giulia 0.2 ]
    turism [ mountain 0.5 lake 0.2 sea 0.5 ] ))
  (expertise (user-attribute turism) (value lake) (inference
    region [ piemonte 0.5 liguria -0.8 toscana -0.8 lombardia 0.8 valle-d'aosta -0.2 trentino-alto-adige 0.5 veneto 0.2 umbria 0.2 marche -0.5 ]
    turism [ sea 0.5 naturalistic 0.5 ] ))
  (expertise (user-attribute turism) (value naturalistic) (inference
    region [ piemonte 0.5 liguria 0.5 toscana 0.2 valle-d'aosta 0.8 trentino-alto-adige 0.8 veneto -0.2 emilia-romagna -0.5 marche -0.2 friuli-venezia-giulia 0.2 ]
    turism [ mountain 0.5 lake 0.5 ] ))
  (expertise (user-attribute turism) (value cultural) (inference
    region [ piemonte 0.5 liguria -0.5 toscana 0.8 lombardia 0.5 trentino-alto-adige -0.5 veneto 0.5 umbria 0.8 friuli-venezia-giulia 0.2 ]
    turism [ religious 0.5 ] ))
  (expertise (user-attribute turism) (value termal) (inference
    region [ liguria -0.5 toscana 0.5 lombardia 0.5 valle-d'aosta 0.2 trentino-alto-adige 0.8 emilia-romagna -0.5 ]
    turism [ mountain 0.2 ] ))
  (expertise (user-attribute turism) (value religious) (inference
    region [ piemonte 0.5 liguria -0.2 toscana 0.5 lombardia 0.2 trentino-alto-adige -0.5 umbria 0.8 marche 0.5 ]
    turism [ cultural 0.5 ] ))

  (expertise (user-attribute age-class) (value young) (type profile) (inference 
    turism [ sport 0.5 sea 0.5 religious -0.5 ]))  
  (expertise (user-attribute age-class) (value middle-young) (type profile) (inference 
    turism [ cultural 0.5 enogastronomic 0.5 ]))  
  (expertise (user-attribute age-class) (value middle-old) (type profile) (inference 
    turism [ cultural 0.5 enogastronomic 0.5 mountain 0.5 ]))  
  (expertise (user-attribute age-class) (value old) (type profile) (inference 
    turism [ cultural 0.5 religious 0.5 sport -0.5 termal 0.5 ]))

  (expertise (user-attribute budget-per-day-class) (value low) (type mandatory) (inference
    stars [ 1 0.8 2 0.2 3 -0.5 4 -0.8 ] 
    service [ pool -0.8 room-service -0.8 spa -0.8 ]
    region [ emilia-romagna 0.2 ] ))
  (expertise (user-attribute budget-per-day-class) (value middle-low) (type mandatory) (inference
    stars [ 1 0.2 2 0.8 4 -0.5 ] 
    service [ pool -0.2 room-service -0.5 spa -0.5 parking 0.2 wifi 0.2 tv 0.5 ] ))
  (expertise (user-attribute budget-per-day-class) (value middle-high) (type mandatory) (inference
    stars [ 1 -0.5 3 0.8 4 0.2 ] 
    service [ pool 0.5 room-service 0.5 spa 0.2 parking 0.5 wifi 0.5 tv 0.8 ] ))
  (expertise (user-attribute budget-per-day-class) (value high) (type mandatory) (inference
    stars [ 1 -0.8 2 -0.5 3 0.2 4 0.8 ] 
    service [ pool 0.8 room-service 0.8 spa 0.8 parking 0.8 wifi 0.8 tv 0.8 ] 
    region [ liguria 0.2 valle-d'aosta 0.2 ] ))
  ;Pensare a cosa potrebbe influenzare le stelle di altro 
)

(defrule EXPERTISE::expertise-general-rule
  (user-attribute (name ?user-attribute) (values $? ?value $?) (type ?type))
  (expertise (user-attribute ?user-attribute) (value ?value) (type ?type) 
    (inference $? ?attribute [ $?values&:(not (member ] ?values)) ] $?))  
  =>
  (assert (new-attributes (attribute ?attribute) (values $?values)))
)

(defrule EXPERTISE::create-positive-expertise-attribute
  (new-attributes 
    (attribute ?attribute) 
    (values $?prev ?value ?cf&:(eq (type ?cf) FLOAT)&:(> ?cf 0.0) $?next)
    (deviation ?deviation)
  )
  =>
  (assert 
    (attribute 
      (name ?attribute) 
      (value ?value) 
      (certainty (max (- ?cf ?deviation) 0))
    )
  )
)

(defrule EXPERTISE::create-negative-expertise-attribute
  (new-attributes 
    (attribute ?attribute) 
    (values $?prev ?value ?cf&:(eq (type ?cf) FLOAT)&:(< ?cf 0.0) $?next)
    (deviation ?deviation)
  )
  =>
  (assert 
    (attribute 
      (name ?attribute) 
      (value ?value) 
      (certainty (min (+ ?cf ?deviation) 0))
    )
  )
)

(defrule EXPERTISE::expertise-from-live-region
  (user-attribute (name live-region) (values ?region))
  =>
  (assert (attribute (name region) (value ?region) (certainty -0.5)))
)

(defrule EXPERTISE::expertise-from-last-region-visited-old-people
  (user-attribute (name last-region-visited) (values ?region))
  (user-attribute (name age-class) (values old))
  =>
  (assert (attribute (name region) (value ?region) (certainty 0.5)))
)

(defrule EXPERTISE::expertise-from-last-region-visited-young-people
  (user-attribute (name last-region-visited) (values ?region))
  (user-attribute (name age-class) (values young))
  =>
  (assert (attribute (name region) (value ?region) (certainty -0.5)))
)

(defrule EXPERTISE::expertise-from-favourite-turism
  (user-attribute (name turism) (values $? ?turism $?) (type profile))
  (expertise (user-attribute turism) (value ?turism)
    (inference $? ?attribute [ $?values&:(not (member ] ?values)) ] $?))  
  =>
  (assert (new-attributes (attribute ?attribute) (values $?values) (deviation 0.6)))
)