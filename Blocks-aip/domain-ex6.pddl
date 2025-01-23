(define (domain MONKEY)

    (:requirements :strips)
    (:predicates (at ?x ?y)
                (height ?x ?y)
                (handempty)
                (hold ?x ?y)
                (monkey ?x)
                (box ?x)
                (bananas ?x)
                )

    (:action goto ;; Le singe se déplace du lieu ?x au lieu ?y
        :parameters (?x ?y ?m ?b ?h)
        :precondition (and (monkey ?m) (box ?b) (at ?m ?x) (height ?m ?h) (height ?b ?h))
        :effect
        (and (not (at ?m ?x))
            (at ?m ?y))
    )

    (:action push ;; Le singe ?m en bas pousse la caisse ?b du lieu ?x au lieu ?y
        :parameters (?x ?y ?m ?b ?h)
        :precondition (and (monkey ?m) (box ?b) (at ?m ?x) (at ?b ?x) (height ?m ?h) (height ?b ?h))
        :effect
        (and (not (at ?m ?x))
            (at ?m ?y)
            (not (at ?b ?x))
            (at ?b ?y))
    )

    (:action climb
        :parameters (?x ?h ?m ?b ?ba ?high)
        :precondition (and (monkey ?m) (box ?b) (bananas ?ba) (at ?m ?x) (at ?b ?x) (height ?m ?h) (height ?b ?h) (height ?ba ?high))
        :effect
        (and (not (height ?m ?h))
            (height ?m ?high))
    )

    (:action getdown
        :parameters (?x ?h ?m ?b ?ba ?high)
        :precondition (and (monkey ?m) (box ?b) (bananas ?ba) (at ?m ?x) (at ?b ?x) (height ?m ?high) (height ?b ?h) (height ?ba ?high))
        :effect
        (and (not (height ?m ?high))
            (height ?m ?h))
    )

    (:action grab
        :parameters (?x ?h ?m ?ba)
        :precondition (and (monkey ?m) (bananas ?ba) (at ?m ?x) (at ?ba ?x) (height ?m ?h) (height ?ba ?h) (handempty))
        :effect
        (and (not (handempty))
            (hold ?m ?ba)
            (not (at ?ba ?x))
            (not (heigh ?ba ?h)))
    )

    (:action release
        :parameters (?x ?h ?m ?ba)
        :precondition (and (monkey ?m) (bananas ?ba) (at ?m ?x) (hold ?m ?ba) (height ?m ?h))
        :effect
        (and (not (hold ?m ?ba))
            (handempty)
            (at ?ba ?x)
            (heigh ?ba ?h))
    )
)
