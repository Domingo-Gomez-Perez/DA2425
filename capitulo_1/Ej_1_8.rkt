#lang racket
(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (cbrt-iter (improve guess x) x)))

(define (improve y x) (
    / (+ (/ x (* y y)) (+ y y)) 3
                       ))

(define (good-enough? guess x) (
    < (abs (- (* (* guess guess) guess) x)) 0.001
                                ))

(cbrt-iter 1 27)
(cbrt-iter 1 10)
(cbrt-iter 2 8)