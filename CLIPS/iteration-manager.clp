(defmodule ITERATION-MANAGER (import USER-INTERACTION ?ALL))

(defrule ITERATION-MANAGER::ask-if-refine-search
  (iteration ?i)
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
  ?iteration <- (iteration ?i)
  =>
  (retract ?parameter ?iteration)
  (assert (iteration (+ ?i 1)))
  (return)
)


(deffacts ITERATION-MANAGER::define-ITERATION
  (iteration 1)
)