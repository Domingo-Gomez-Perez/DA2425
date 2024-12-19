#lang racket
(define (f g) (g 2))

(f sqr)

(f (lambda (z) (* z (+ z 1))))

;(f f)
;(f 2)
;(2 2)
; Da error porque 2 no es una funcion