#lang racket
; Ejercicio 2.1
(define (make-rat n d) (
    if (< n 0)
       (if (< d 0)
           (cons (- 0 n) (- 0 d))
           (cons n d)
        )
       (if (< d 0)
           (cons (- 0 n) (- 0 d))
           (cons n d)
        )
                        ))

(make-rat 2 -3)