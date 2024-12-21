#lang racket
(define (TRUE x y) x)
(define (FALSE x y) y)

(define NOT (lambda (f) (f FALSE TRUE)))

(displayln "NOT:")
(NOT TRUE)
(NOT FALSE)

(define (AND x y) ((TRUE x y) y x))

(displayln "AND:")
(AND TRUE TRUE)    ;-> TRUE
(AND TRUE FALSE)   ;-> FALSE
(AND FALSE TRUE)   ;-> FALSE
(AND FALSE FALSE)   ;-> FALSE

(define (OR x y) ((FALSE y x) x y))

(displayln "OR:")
(OR TRUE TRUE)    ;-> TRUE
(OR TRUE FALSE)   ;-> TRUE
(OR FALSE TRUE)   ;-> TRUE
(OR FALSE FALSE)   ;-> FALSE