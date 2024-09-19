#lang racket

(define x 5)
(+ (let ((x 3))
        (+ x (* x 10)))
   x)

;Da 38, ni 36 ni 60 porque el procedimiento se lleva a cabo en entornos ('environments') distintos.
;En (+ x (* x 10)), x=3, por lo que da 33. Después se vuelve al entorno global donde x=5, por lo que
;(+ 33 x) = (+ 33 5) = 38.