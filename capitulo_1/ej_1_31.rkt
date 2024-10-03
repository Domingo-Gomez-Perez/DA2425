#lang racket

; Exercise 1.31

; 1. The `sum` procedure is only the simplest of a vast number of similar
; abstractions that can be captured as higher-order procedures. Write an analogous
; procedure called `product` that returns the product of the values of a
; function at points over a given range. Show how to define `factorial` in
; terms of `product`. Also use `product` to compute approximations to
; `pi` using the formula

; pi   2 * 4 * 4 * 6 * 6 * 8 ...
; -- = -------------------------
; 4    3 * 3 * 5 * 5 * 7 * 7 ...

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
        (product term (next a) next b))))


; factorial function
(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(factorial 10) ; 3628800
(factorial 6)  ; 720


; pi function
(define (pi accuracy)
  (* 4.0
    (/ (* (product (lambda (x) x) 2 (lambda (x) (+ x 2)) (+ (* accuracy 2) 2))
          (product (lambda (x) x) 4 (lambda (x) (+ x 2)) (+ (* accuracy 2) 4)))
        (* (product (lambda (x) x) 3 (lambda (x) (+ x 2)) (+ (* accuracy 2) 3))
          (product (lambda (x) x) 3 (lambda (x) (+ x 2)) (+ (* accuracy 2) 3))))))

(pi 10000) ; 3.1416711786826412
              


; 2. If your `product` procedure generates a recursive process, write one that
; generates an iterative process. If it generates an iterative process, write
; one that generates a recursive process.

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))


; pi-iter function
(define (pi-iter accuracy)
  (* 4.0
    (/ (* (product-iter (lambda (x) x) 2 (lambda (x) (+ x 2)) (+ (* accuracy 2) 2))
          (product-iter (lambda (x) x) 4 (lambda (x) (+ x 2)) (+ (* accuracy 2) 4)))
        (* (product-iter (lambda (x) x) 3 (lambda (x) (+ x 2)) (+ (* accuracy 2) 3))
          (product-iter (lambda (x) x) 3 (lambda (x) (+ x 2)) (+ (* accuracy 2) 3))))))

(pi-iter 10000) ; 3.1416711786826412

