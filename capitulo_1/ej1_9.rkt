#lang racket

;EJERCICIO 1.9

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))
(plus 4 5)

;(plus 4 5)
;(+ (plus 3 5) 1)
;(+ (plus 2 5) 1 1)
;(+ (plus 1 5) 1 1 1)
;(+ (plus 0 5) 1 1 1 1)
;(+ 5 1 1 1 1)
;(+ 6 1 1 1)
;(+ 7 1 1)
;(+ 8 1)
;9

(define (plus a b)
  (if (= a 0) 
      b 
      (plus (dec a) (inc b))))

(plus 4 5)
;plus 4 5 llama a plus 3 6.
;plus 3 6 llama a plus 2 7.
;plus 2 7 llama a plus 1 8.
;plus 1 8 llama a plus 0 9.
;plus 0 9 retorna 9.