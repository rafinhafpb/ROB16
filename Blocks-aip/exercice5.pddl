(define (problem PATH-1)
(:domain PATH)
(:objects A B C D E)
(:INIT (at A) (edge A B) (edge A C) (edge B D) (edge D E) (edge C E))
(:goal (AND (at E)))
)