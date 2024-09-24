#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (improve x y) (
    avg x (/ y x)       
                       ))

(define (avg x y) (
    * 0.5 (+ x y)
                   ))

(define (good-enough? guess x) (
    < (abs (- (* guess guess) x)) 0.001
                                ))

(sqrt-iter 1 2)
(sqrt-iter 2 4)

; Sucede que no funciona a menos que uses el if original, porque racket sigue un orden normal para las
; funciones, pero no para el if definido. El if que nos da racket no resuelve el else si la condición se
; cumple, cosa que new-if no hace por seguir un orden normal, lo cual causa que caiga en un bucle infinito.