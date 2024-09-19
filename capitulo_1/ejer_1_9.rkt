#lang racket
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))

(define (plus a b)
  (if (= a 0) 
      b 
      (plus (dec a) (inc b))))

(plus 4 5)

;Para la primera función:
;(plus 4 5)
;(+ (plus 3 5) 1)
;(+ (plus 2 5) 1 1)
;(+ (plus 1 5) 1 1 1)
;(+ (plus 0 5) 1 1 1 1)
;(+ 5 1 1 1 1)
;9

;Para la segunda función:
;(plus 4 5)
;(plus 3 6)
;(plus 2 7)
;(plus 1 8)
;(plus 0 9)
;9

;La anchura de cada procedimiento permite visualizar que en la primera función se hace uso de un
;stack, mientras que en la segunda no (recursión de cola). Esto significa que el primer proceso es
;recursivo, mientras que el segundo es iterativo.