#lang racket

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (good-enough? guess x)
  (< (abs (- (* guess guess) x)) 0.001))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))


(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
;Al usar el new if se evalua tanto el "then" y el "else" de la funcion, lo que viene
;a ser el "guess" y el "sqrt-iter", provocando llamadas recursivas a este ultimo,
;convirtiendolo en un bucle infinito. 