#lang racket
;Show that sum and product are both special cases of a still more general notion called accumulate that combines a collection of terms, using some general accumulation function:;

;(accumulate combiner null-value term a next b)
;Accumulate takes as arguments the same term and range specifications as sum and product, together with a combiner procedure (of two arguments) that specifies how the current term
;is to be combined with the accumulation of the preceding terms and a null-value that specifies what base value to use when the terms run out.
;Write accumulate and show how sum and product can both be defined as simple calls to accumulate.
(define (igual x) x)
(define (siguiente x) (+ x 1))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(accumulate * 1 igual 1 siguiente 5) 

;Defino sum y product usando accumulate
(define (sum term a next b) (accumulate + 0 term a next b))
(sum igual 1 siguiente 5)

(define (product term a next b) (accumulate * 1 term a next b))
(product igual 1 siguiente 5)
  
;If your accumulate procedure generates a recursive process, write one that generates an iterative process.
;If it generates an iterative process, write one that generates a recursive process.
;Paso accumulate a iterativo
(define (accumulate-iter combiner total term a next b)
  (if (> a b)
      total
      (accumulate-iter combiner (combiner (term a) total) term (next a) next b)))

;Hay que tener en cuenta que total debe ser iniciado a 0 si combiner es + y a 1 si combiner es *
(accumulate-iter * 1 igual 1 siguiente 5)
(accumulate-iter + 0 igual 1 siguiente 5) 