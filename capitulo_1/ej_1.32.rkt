#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.32: Show that `sum` and `product` are both special cases of a still more general notion
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

; posibles procedimientos para usar en acumulate
(define (identity x) x)
(define (increment x) (+ x 1))
(define (square x) (* x x))
(define (cube x) (* x x x))


; proceso recursivo
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))


; proceso iterativo (procedimiento recursivo)
(define (accumulate-iter combiner null-value term a next b)
  (define (accumulate-iter-cap a result)
    (if (> a b)
        result
        (accumulate-iter-cap (next a) (combiner (term a) result))))

  ; iniciamos el proceso con el resultado a null-value
  (accumulate-iter-cap a null-value))

; probamos ambos
(accumulate + 0 identity 1 increment 5)
(accumulate-iter + 0 identity 1 increment 5)

; las dos que nos piden
(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))


(sum identity 1 increment 5) ; da 15
(product identity 1 increment 5) ; da 120
