(defmodule ITERATION-MANAGER (import USER-INTERACTION ?ALL))

(defrule ITERATION-MANAGER::ask-if-refine-search
  (iteration)
  =>
  (assert 
    (menu-question
      (question "Dou you want to refine your search? (y/n) ")
      (valid-answers y n)
    )
  )
  (focus USER-INTERACTION)
)

(defrule ITERATION-MANAGER::stop-search
  ?parameter <- (search-parameter n)
  =>
  (retract ?parameter)
)

(defrule ITERATION-MANAGER::refine-search
  ?parameter <- (search-parameter y)
  ?iteration <- (iteration (number ?i))
  =>
  (modify ?iteration (number (+ ?i 1)))
  (retract ?parameter ?iteration)
  (return)
)