#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define range 10000) ;La modificación a este valor dispar demuestra que el error no está en los
;cálculos en sí mismos

(define (abs x) (if (< x 0) (- x) x))

(define (square x) (* x x))

(define (sqrt-iter guess x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) range))
  (define (average x y) 
    (/ (+ x y) 2))
  (define (improve guess x)
    (average guess (/ x guess)))
  
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(sqrt-iter 1.0 2.0)

;Como el orden de substitución es aplicativo, antes de ejecutarse el new-if de la línea 22, se
;ejecutan sus argumentos, entre los que está sqrt-iter. Dentro de sqrt-iter, está ese mismo new-if
;otra vez, por lo que se entra en un bucle recursivo infinito.