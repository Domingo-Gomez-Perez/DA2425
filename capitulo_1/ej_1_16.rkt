#lang racket

; Exercise 1.16

; Design an iterative version of the `fast-expt` procedure given in the text.

; Hint: to do this, it might help to use a subtle trick of algorithm design.
; Normally when implementing an algorithm, you're thinking about how to break a problem down into smaller and smaller steps (e.g., subdividing the problem into parts).
; However, sometimes it might make sense to change the problem into a different, but equivalent problem.
; For example, suppose you were computing `2^16`. You could rewrite this problem by doubling the base and halving the exponent.
; Thus, it's really the same as computing `4^8`. Perhaps this trick could be used in your solution.


(define (even? x)
  (= (remainder x 2) 0))

(define (square x)
  (* x x)) 

(define (fast-expt b n) 
  (fast-expt-iter-aux b n 1))

(define (fast-expt-iter-aux b n product)
  (cond ((= n 0) product)
        ((even? n) (fast-expt-iter-aux (square b) (/ n 2) product))
        (else (fast-expt-iter-aux b (- n 1) (* b product)))))

(fast-expt 2 16)
(fast-expt 4 8)
(fast-expt 11 3)

; (fast-expt 11 3) 
; (fast-expt-iter-aux 11 3 1)
; (fast-expt-iter-aux 11 (- 3 1) (* 11 1))
; (fast-expt-iter-aux 11 2 11)
; (fast-expt-iter-aux (square 11) (/ 2 2) 11)
; (fast-expt-iter-aux 121 1 11)
; (fast-expt-iter-aux 121 (- 1 1) (* 121 11))
; (fast-expt-iter-aux 121 0 1331)
; 1331