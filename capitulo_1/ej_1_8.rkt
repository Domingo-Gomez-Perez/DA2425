#lang racket
;x/y^2 + 2y
;----------
;    3
(define (cube-root x y)
  (/ (+ (/ x (* y y)) (* y 2)) 3))