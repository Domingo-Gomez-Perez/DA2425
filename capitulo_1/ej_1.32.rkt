#lang racket

; Hecho por:
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.32:

Show that `sum` and `product` are both special cases of a still more general notion 
called `accumulate` that combines a collection of terms using some general accumulation function:

(accumulate combiner null-value term a next b)

`Accumulate` takes as arguments the same term and range specifications as `sum` and `product`, 
together with a combiner procedure (of two arguments) that specifies how the current term is to
 be combined with the accumulation of the preceding terms, and a null-value that specifies what
  base value to use when the terms run out.

Write `accumulate` and show how `sum` and `product` can both be defined as simple calls to `accumulate`.

If your `accumulate` procedure generates a recursive process, write one that generates an 
iterative process. If it generates an iterative process, write one that generates a recursive process.
|#

(define (cube x) (*(* x x) x))
(define (increment x) (+ x 1))


;Versión Iterativa
(define (accumulate_iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


;Versión Recursiva
(define (accumulate_rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate_rec combiner null-value term (next a) next b))))

;Pruebas método iterativo
(accumulate_iter + 0 cube 1 increment 3); 0^3 + 1^3 + 2^3 + 3^3 = 1 + 8 + 27 = 36
(accumulate_iter * 0 cube 1 increment 3); 0^3 * 1^3 * 2^3 * 3^3 = 0

;Pruebas método recursivo
(accumulate_rec + 0 cube 1 increment 3); 0^3 + 1^3 + 2^3 + 3^3 = 1 + 8 + 27 = 36
(accumulate_rec * 0 cube 1 increment 3); 0^3 * 1^3 * 2^3 * 3^3 = 0