#lang racket

;Esta version hace que si el denominador es negativo solo
;aparezca el - en el numerador
(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (< d 0)
        (cons (/ (- n) g) (/ (- d) g))
    (cons (/ n g) (/ d g)))))
