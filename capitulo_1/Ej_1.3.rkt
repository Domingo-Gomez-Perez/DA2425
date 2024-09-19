#lang racket
(define (square_larger x y z)
(cond ((and (>= x z) (>= y z)) (+ (* x x) (* y y)))
      ((and (>= x y) (>= z y)) (+ (* x x) (* z z)))
      ((and (>= y x) (>= z x)) (+ (* z z) (* y y)))
  ))

;Ejemplos
(square_larger 0 0 0)

(square_larger 0 10 0)

(square_larger -10 -5 -1)

(square_larger 10 20 1)