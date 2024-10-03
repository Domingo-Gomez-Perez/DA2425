#lang racket

; Exercise 1.6

; Alyssa P. Hacker doesn't see why `if` needs to be provided as a special form. 
; "Why can't I just define it as an ordinary procedure in terms of `cond`" she asks. 
; Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

; Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5) ; Evaluates to 5 because (= 2 3) is false
(new-if (= 1 1) 0 5) ; Evaluates to 0 because (= 1 1) is true

; Delighted, Alyssa uses `new-if` to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))


(define (square x)
  (* x x))


(sqrt-iter 3.1 9) ; Infinite recursion

; What happens when Alyssa attempts to use this to compute square roots?

; Explanation:

; sqrt-iter is a recursive function that attempts to compute the square root of x starting with an initial guess.
; It uses new-if to decide whether to return the current guess or to continue the iteration with an improved guess.

; In Scheme, all arguments to a procedure are evaluated before the procedure itself is called.
; This means that both then-clause and else-clause are evaluated before new-if is executed.

; When new-if is called, both guess and (sqrt-iter (improve guess x) x) are evaluated regardless of the result of (good-enough? guess x).
; This leads to the recursive call (sqrt-iter (improve guess x) x) being evaluated every time new-if is called, causing infinite recursion.


; Using the normal if, it works correctly because the else-clause is only evaluated if the predicate is false.

; (define (sqrt-iter guess x)
;   (if (good-enough? guess x)
;           guess
;           (sqrt-iter (improve guess x) x)))


; (sqrt-iter 3.1 9) ; Evaluates to 3.0000... because