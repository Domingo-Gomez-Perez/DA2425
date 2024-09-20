#lang racket
(define (sq1 x y z) ((if (> x y z)
                        (+ (* x x) (* y y))
                        ()
                         ) )
  )