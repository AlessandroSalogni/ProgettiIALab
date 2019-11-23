(defmodule EXPERTISE (import MAIN ?ALL) (import USER-INTERACTION ?ALL) (import ITERATION-MANAGER ?ALL))

(deftemplate EXPERTISE::expertise
  (slot user-attribute)
  (slot value)
  (slot type (allowed-symbols mandatory optional profile inferred) (default optional))
  (multislot inference)
)

(deftemplate EXPERTISE::new-attributes
  (slot attribute)
  (multislot values)
  (slot deviation (type FLOAT) (range 0.0 1.0) (default 0.0))
  (slot iteration)
)

(deffacts EXPERTISE::expertise-knowledge
  (expertise (user-attribute region) (value piemonte) (inference
    turism [ sea -0.6 mountain 0.6 enogastronomic 0.6 lake 0.4 termal 0.2 religious 0.4 cultural 0.4 ]
    region [ liguria 0.2 toscana -0.4 lombardia 0.6 valle-d'aosta 0.6 veneto -0.2 umbria -0.2 marche -0.8 friuli-venezia-giulia -0.6 ] ))
  (expertise (user-attribute region) (value liguria) (inference
    turism [ sea 0.6 mountain 0.2 enogastronomic 0.4 lake -0.6 termal -0.4 sport 0.2 naturalistic 0.4 ]
    region [ piemonte 0.2 toscana 0.6 lombardia -0.2 valle-d'aosta -0.6 trentino-alto-adige -0.8 emilia-romagna 0.2 umbria -0.6 ] ))
  (expertise (user-attribute region) (value toscana) (inference
    turism [ sea 0.6 mountain -0.2 enogastronomic 0.4 lake -0.6 sport 0.2 naturalistic 0.6 religious 0.2 cultural 0.6 ]
    region [ piemonte -0.4 liguria 0.6 valle-d'aosta -0.8 trentino-alto-adige -0.8 emilia-romagna 0.4 umbria 0.4 marche 0.2 ] ))
  (expertise (user-attribute region) (value lombardia) (inference
    turism [ sea -0.6 mountain 0.4 enogastronomic 0.2 lake 0.6 sport -0.2 cultural 0.4 ]
    region [ piemonte 0.6 liguria -0.2 toscana -0.4 valle-d'aosta 0.4 trentino-alto-adige 0.4 emilia-romagna 0.4 veneto -0.2 umbria -0.2 marche -0.8 friuli-venezia-giulia -0.6 ] ))
  (expertise (user-attribute region) (value valle-d'aosta) (inference
    turism [ sea -0.8 mountain 0.8 lake 0.2 termal 0.6 sport 0.2 naturalistic 0.4 cultural -0.4 ]
    region [ piemonte 0.6 liguria -0.6 toscana -0.8 lombardia 0.4 trentino-alto-adige 0.2 emilia-romagna -0.4 umbria -0.6 marche -0.8 ] ))
  (expertise (user-attribute region) (value trentino-alto-adige) (inference
    turism [ sea -0.8 mountain 0.8 enogastronomic 0.2 lake 0.4 termal 0.4 sport 0.4 naturalistic 0.4 religious -0.4 cultural -0.4 ]
    region [ liguria -0.8 toscana -0.8 lombardia 0.4 veneto 0.2 umbria -0.4 marche -0.8 friuli-venezia-giulia 0.2] ))
  (expertise (user-attribute region) (value veneto) (inference
    turism [ sea 0.4 lake 0.6 religious 0.2 cultural 0.6 ]
    region [ piemonte -0.2 lombardia -0.2 trentino-alto-adige 0.2 emilia-romagna 0.6 marche 0.2 friuli-venezia-giulia 0.4 ] ))
  (expertise (user-attribute region) (value emilia-romagna) (inference
    turism [ sea 0.4 mountain -0.8 enogastronomic 0.4 lake 0.2 cultural 0.2 ]
    region [ liguria 0.2 toscana 0.4 lombardia 0.4 valle-d'aosta -0.4 veneto 0.6 umbria 0.4 marche 0.6 ] ))
  (expertise (user-attribute region) (value umbria) (inference
    turism [ sea -0.8 mountain 0.4 enogastronomic 0.2 lake 0.2 sport -0.2 religious 0.6 cultural 0.6 ]
    region [ liguria -0.8 toscana 0.4 lombardia -0.2 valle-d'aosta -0.6 trentino-alto-adige -0.4 emilia-romagna 0.4 marche 0.2 ] ))
  (expertise (user-attribute region) (value marche) (inference
    turism [ sea 0.8 mountain -0.2 enogastronomic 0.2 sport 0.2 religious -0.4 ]
    region [ piemonte -0.8 toscana 0.2 lombardia -0.8 valle-d'aosta -0.8 trentino-alto-adige -0.8 emilia-romagna 0.6 veneto 0.2 umbria 0.2 ] ))
  (expertise (user-attribute region) (value friuli-venezia-giulia) (inference
    turism [ sea 0.4 mountain 0.4 sport 0.4 naturalistic 0.2 ]
    region [ piemonte -0.6 lombardia -0.4 trentino-alto-adige 0.2 veneto 0.4 ] ))
  
  ; ----- Turism -----
  (expertise (user-attribute turism) (value sea) (inference
    region [ piemonte -0.6 liguria 0.6 toscana 0.6 lombardia -0.6 valle-d'aosta -0.6 trentino-alto-adige -0.6 veneto 0.4 emilia-romagna 0.6 umbria -0.4 marche 0.4 friuli-venezia-giulia 0.2 ]
    turism [ mountain -0.6 lake 0.4 ] ))
  (expertise (user-attribute turism) (value mountain) (inference
    region [ piemonte 0.6 liguria -0.2 toscana -0.2 lombardia 0.4 valle-d'aosta 0.6 trentino-alto-adige 0.6 emilia-romagna -0.6  marche -0.4 friuli-venezia-giulia 0.2 ]
    turism [ sea -0.6 lake 0.4 termal 0.2 naturalistic 0.4 ] ))
  (expertise (user-attribute turism) (value enogastronomic) (inference
    region [ piemonte 0.4 liguria 0.4 toscana 0.6 valle-d'aosta 0.2 trentino-alto-adige 0.2 veneto 0.4 emilia-romagna 0.6 umbria 0.4 ]
    turism [ ] ))
  (expertise (user-attribute turism) (value sport) (inference
    region [ liguria 0.2 lombardia -0.2 valle-d'aosta 0.4 trentino-alto-adige 0.4 emilia-romagna 0.2 marche 0.2 friuli-venezia-giulia 0.2 ]
    turism [ mountain 0.4 lake 0.2 sea 0.4 ] ))
  (expertise (user-attribute turism) (value lake) (inference
    region [ piemonte 0.4 liguria -0.6 toscana -0.6 lombardia 0.6 valle-d'aosta -0.2 trentino-alto-adige 0.4 veneto 0.2 umbria 0.2 marche -0.4 ]
    turism [ sea 0.4 naturalistic 0.4 ] ))
  (expertise (user-attribute turism) (value naturalistic) (inference
    region [ piemonte 0.4 liguria 0.4 toscana 0.2 valle-d'aosta 0.6 trentino-alto-adige 0.6 veneto -0.2 emilia-romagna -0.4 marche -0.2 friuli-venezia-giulia 0.2 ]
    turism [ mountain 0.4 lake 0.4 ] ))
  (expertise (user-attribute turism) (value cultural) (inference
    region [ piemonte 0.4 liguria -0.4 toscana 0.6 lombardia 0.4 trentino-alto-adige -0.4 veneto 0.4 umbria 0.6 friuli-venezia-giulia 0.2 ]
    turism [ religious 0.4 ] ))
  (expertise (user-attribute turism) (value termal) (inference
    region [ liguria -0.4 toscana 0.4 lombardia 0.4 valle-d'aosta 0.2 trentino-alto-adige 0.6 emilia-romagna -0.4 ]
    turism [ mountain 0.2 ] ))
  (expertise (user-attribute turism) (value religious) (inference
    region [ piemonte 0.4 liguria -0.2 toscana 0.4 lombardia 0.2 trentino-alto-adige -0.4 umbria 0.6 marche 0.4 ]
    turism [ cultural 0.4 ] ))

  ; (expertise (user-attribute age-class) (value young) (type inferred) (inference 
  ;   turism [ sport 0.4 sea 0.4 religious -0.2 ]))  
  ; (expertise (user-attribute age-class) (value middle-young) (type inferred) (inference 
  ;   turism [ cultural 0.2 enogastronomic 0.2 ]))  
  ; (expertise (user-attribute age-class) (value middle-old) (type inferred) (inference 
  ;   turism [ cultural 0.2 enogastronomic 0.2 mountain 0.2 ]))  
  ; (expertise (user-attribute age-class) (value old) (type inferred) (inference 
  ;   turism [ cultural 0.2 religious 0.2 sport -0.2 termal 0.2 ]))

  (expertise (user-attribute budget-per-day-class) (value low) (type inferred) (inference
    stars [ 1 0.8 2 0.2 3 -0.4 4 -0.8 ] 
    service [ pool -0.8 room-service -0.8 spa -0.8 ]
    region [ emilia-romagna 0.2 ] ))
  (expertise (user-attribute budget-per-day-class) (value middle-low) (type inferred) (inference
    stars [ 1 0.2 2 0.8 4 -0.6 ] 
    service [ pool -0.2 room-service -0.6 spa -0.6 parking 0.2 wifi 0.2 tv 0.6 ] ))
  (expertise (user-attribute budget-per-day-class) (value middle-high) (type inferred) (inference
    stars [ 1 -0.6 3 0.8 4 0.2 ] 
    service [ pool 0.4 room-service 0.4 spa 0.2 parking 0.6 wifi 0.6 tv 0.8 ] ))
  (expertise (user-attribute budget-per-day-class) (value high) (type inferred) (inference
    stars [ 1 -0.8 2 -0.4 3 0.2 4 0.8 ] 
    service [ pool 0.8 room-service 0.8 spa 0.8 parking 0.8 wifi 0.8 tv 0.8 ] 
    region [ liguria 0.2 valle-d'aosta 0.2 ] ))
  ;Pensare a cosa potrebbe influenzare le stelle di altro 
)

(defrule EXPERTISE::expertise-general-rule
  (iteration ?i)
  (user-attribute (name ?user-attribute) (values $? ?value $?) (type ?type) (desire TRUE)) ;TODO vedere se negare expertise
  (expertise (user-attribute ?user-attribute) (value ?value) (type ?type) 
    (inference $? ?attribute [ $?values&:(not (member ] ?values)) ] $?))  
  =>
  (assert (new-attributes (attribute ?attribute) (values $?values) (iteration ?i)))
)

(defrule EXPERTISE::create-positive-expertise-attribute
  (new-attributes 
    (attribute ?attribute) 
    (values $?prev ?value ?cf&:(eq (type ?cf) FLOAT)&:(> ?cf 0.0) $?next)
    (deviation ?deviation)
    (iteration ?i)
  )
  =>
  (assert 
    (attribute 
      (name ?attribute) 
      (value ?value) 
      (certainty (max (- ?cf ?deviation) 0.0))
      (iteration ?i)
    )
  )
)

(defrule EXPERTISE::create-negative-expertise-attribute
  (new-attributes 
    (attribute ?attribute) 
    (values $?prev ?value ?cf&:(eq (type ?cf) FLOAT)&:(< ?cf 0.0) $?next)
    (deviation ?deviation)  
    (iteration ?i)
  )
  =>
  (assert 
    (attribute 
      (name ?attribute) 
      (value ?value) 
      (certainty (min (+ ?cf ?deviation) 0.0))
      (iteration ?i)
    )
  )
)

(defrule EXPERTISE::expertise-from-live-region
  (iteration ?i)
  (user-attribute (name live-region) (values ?region))
  =>
  (assert (attribute (name region) (value ?region) (certainty -0.8) (iteration ?i)))
)

(defrule EXPERTISE::expertise-from-last-region-visited-old-people
  (iteration ?i)
  (user-attribute (name last-region-visited) (values ?region))
  (user-attribute (name age-class) (values old))
  =>
  (assert (attribute (name region) (value ?region) (certainty 0.4) (iteration ?i)))
)

(defrule EXPERTISE::expertise-from-last-region-visited-young-people
  (iteration ?i)
  (user-attribute (name last-region-visited) (values ?region))
  (user-attribute (name age-class) (values young))
  =>
  (assert (attribute (name region) (value ?region) (certainty -0.4) (iteration ?i)))
)

(defrule EXPERTISE::expertise-from-favourite-turism
  (iteration ?i)
  (user-attribute (name turism) (values $? ?turism $?) (type profile))
  (expertise (user-attribute turism) (value ?turism)
    (inference $? ?attribute [ $?values&:(not (member ] ?values)) ] $?))  
  =>
  (assert (new-attributes (attribute ?attribute) (values $?values) (deviation 0.4) (iteration ?i)))
)

(defrule EXPERTISE::expertise-for-number-of-places-not-defined
  (not (attribute (name number-places) (value ?number-places)))
  =>
  (assert (user-attribute (name number-places) (values 1)))
)