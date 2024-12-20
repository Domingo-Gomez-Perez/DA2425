#lang racket
(define (TRUE x y) x)
(define (FALSE x y) y)

(define (NOT p) (p FALSE TRUE))
(define (AND x y) (x y FALSE))
(define (OR x y) (x TRUE y))

; Example
(NOT TRUE)         ;-> FALSE
(NOT FALSE)        ;-> TRUE
(AND TRUE TRUE)    ;-> TRUE
(AND TRUE FALSE)   ;-> FALSE
(AND FALSE TRUE)   ;-> FALSE
(OR TRUE FALSE)    ;-> TRUE