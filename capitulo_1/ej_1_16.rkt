#lang racket
;Exercise 1.16: Design an iterative version of the fast-expt procedure given in the text. Hint: to do this, it might help to use a subtle trick of algorithm design.
;Normally when implementing an algorithm, you're thinking about how to break a problem down into smaller and smaller steps (e.g., subdividing the problem into parts).
;However, sometimes it might make sense to change the problem into a different, but equivalent problem. For example, suppose you were computing 2^16.
;You could rewrite this problem by doubling the base and halving the exponent. Thus, it's really the same as computing 4^8. Perhaps this trick could be used in your solution.

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (fast-exptiteraux b n contador)
  (cond ((= n 0) 1 * contador)
        ((even? n) (fast-exptiteraux (square b) (/ n 2) contador))
        (else (fast-exptiteraux b (- n 1) (* contador b)))))

(define (fast-exptiter b n) (fast-exptiteraux b n 1))

        
(fast-expt 3 5)
(fast-exptiter 3 5)



