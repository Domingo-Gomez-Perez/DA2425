#lang racket 

; **Exercise 1.32:**

; 1. 

; Show that `sum` and `product` are both special
; cases of a still more general notion called `accumulate` that combines a
; collection of terms, using some general accumulation function:

; ```
; (accumulate combiner null-value term a next b)
; ```

; `Accumulate` takes as arguments the same term and range specifications as
; `sum` and `product`, together with a `combiner` procedure (of
; two arguments) that specifies how the current term is to be combined with the
; accumulation of the preceding terms and a `null-value` that specifies what
; base value to use when the terms run out.  Write `accumulate` and show how
; `sum` and `product` can both be defined as simple calls to `accumulate`.

; 2. If your `accumulate` procedure generates a recursive process, write one
; that generates an iterative process.  If it generates an iterative process,
; write one that generates a recursive process.


(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))


(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))


(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(sum-iter identity 1 add1 5)
; Resultado esperado: 15 (1 + 2 + 3 + 4 + 5)
(sum identity 1 add1 5)
; Resultado esperado: 15 (1 + 2 + 3 + 4 + 5)
(product identity 1 add1 5)
; Resultado esperado: 120 (1 * 2 * 3 * 4 * 5)
(product-iter identity 1 add1 5)
; Resultado esperado: 120 (1 * 2 * 3 * 4 * 5)
(sum (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 14 (1^2 + 2^2 + 3^2)
(sum-iter (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 14 (1^2 + 2^2 + 3^2)
(product (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 36 (1^2 * 2^2 * 3^2)
(product-iter (lambda (x) (* x x)) 1 add1 3)
; Resultado esperado: 36 (1^2 * 2^2 * 3^2)
(sum identity 2 (lambda (x) (+ x 2)) 10)
; Resultado esperado: 30 (2 + 4 + 6 + 8 + 10)
(sum-iter identity 2 (lambda (x) (+ x 2)) 10)
; Resultado esperado: 30 (2 + 4 + 6 + 8 + 10)
(product identity 1 (lambda (x) (+ x 2)) 9)
; Resultado esperado: 945 (1 * 3 * 5 * 7 * 9)
(product-iter identity 1 (lambda (x) (+ x 2)) 9)
; Resultado esperado: 945 (1 * 3 * 5 * 7 * 9)
(sum identity -5 add1 -1)
; Resultado esperado: -15 (-5 + -4 + -3 + -2 + -1)
(sum-iter identity -5 add1 -1)
; Resultado esperado: -15 (-5 + -4 + -3 + -2 + -1)
(product identity -3 add1 -1)
; Resultado esperado: -6 (-3 * -2 * -1)
(product-iter identity -3 add1 -1)
; Resultado esperado: -6 (-3 * -2 * -1)
(sum sqrt 1 add1 4)
; Resultado esperado: 6 (sqrt(1) + sqrt(2) + sqrt(3) + sqrt(4))
(sum-iter sqrt 1 add1 4)
; Resultado esperado: 6 (sqrt(1) + sqrt(2) + sqrt(3) + sqrt(4))
(product (lambda (x) (* 2 x)) 1 add1 4)
; Resultado esperado: 384 (2*1 * 2*2 * 2*3 * 2*4)
(product-iter (lambda (x) (* 2 x)) 1 add1 4)
; Resultado esperado: 384 (2*1 * 2*2 * 2*3 * 2*4)
