#lang racket

; Exercise 2.5

; Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations
; if we represent the pair `a` and `b` as the integer that is the product `2^a * 3^b`.

; Give the corresponding definitions of the procedures `cons`, `car`, and `cdr`.

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car c)
  (if (= (remainder c 2) 0)
      (+ 1 (car (/ c 2)))
      0
   ))

(define (cdr c)
    (if (= (remainder c 3) 0)
      (+ 1 (car (/ c 3)))
      0
   ))

; Tests
(define pair (cons 5 6))

pair       ; should return 23328
(car pair) ; should return 5
(cdr pair) ; should return 6