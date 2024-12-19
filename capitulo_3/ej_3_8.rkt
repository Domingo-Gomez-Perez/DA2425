#lang racket
;Ejercicio 3.8
(define valor -1/2)
(define (f x)
    (set! valor (+ valor x))
    valor
    )


;(+ (f 0) (f 1)) ;0
(+ (f 1) (f 0)) ;1