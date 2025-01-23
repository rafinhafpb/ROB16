(define (domain PATH)
  (:requirements : strips)
  (:predicates
        (at ?from)
        (edge ?from ?to)
        )
  (:action move     ;;;
        :parameters (?from ?to)
        :precondition (and (at ?from) (edge ?from ?to))
        :effect
        (and (not (at ?from))
          (at ?to))))