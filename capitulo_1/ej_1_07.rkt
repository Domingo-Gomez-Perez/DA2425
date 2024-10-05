#lang racket

; Exercise 1.7

; The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers.
; Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers.
; Explain these statements, with examples showing how the test fails for small and large numbers.
; An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess.
; Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?


(define (sqrt-iter guess x)
    (if (good-enough? guess x)
		guess
        (sqrt-iter (improve guess x) x)))

(define (improve guess x)
	(/ (+ guess (/ x guess)) 2))

(define (square x)
	(* x x))


; We will change the good-enoght? function to check the relative error between the guess and the square root of x
; Now, instead of using a fixed value, we will use a fraction of the guess to determine if the guess is good enough
; Applying this relative error, we can use the same function for small and large numbers


; BEFORE --------------------------------------------------

; (define (good-enough? guess x)
;  (< (abs (- (square guess) x)) 0.001))

; (sqrt-iter 0.1 0.00001) ; 0.0251249000999001   and   0.02512490 ^ 2 = 0.000631


; AFTER --------------------------------------------------
; Despite working, by using an smaller value for the relative error, we can get a sharper result

(define (good-enough? guess x)
	(< (/ (abs (- (square guess) x)) guess) 0.001))

(sqrt-iter 0.1 0.00001) ; 0.0032745269344488636   and   0.0032745 ^ 2 = 0.00001

