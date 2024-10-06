#lang racket

; **Exercise 2.1:** Define a better version of
; `make-rat` that handles both positive and negative arguments.
; `Make-rat` should normalize the sign so that if the rational number is
; positive, both the numerator and denominator are positive, and if the rational
; number is negative, only the numerator is negative.

(define (make-rat-obsoleto n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))

(define (make-rat num denom)
  (define (gcd a b)
    (if (= b 0)
        (abs a)
        (gcd b (modulo a b))))
  
  (define g (gcd num denom))
  
  (define (normalize n d)
    (cond
      [(and (> n 0) (< d 0)) (values (- n) (abs d))]
      [(and (< n 0) (> d 0)) (values (-(abs n)) (abs d))]
      [else (values (abs n) (abs d))]))
  
  (define-values (num-normalized denom-normalized) (normalize num denom))
  (cons num-normalized denom-normalized))

(display "Fraccion (3/4) \n")
(define r1 (make-rat 3 4))   ; 3/4
(print-rat r1); 
(car r1);3
(cdr r1);4
(newline)
(display"Fraccion (-3/4) \n")
(define r2 (make-rat -3 4))  ; -3/4
(print-rat r2);
(car r2);-3
(cdr r2);4
(newline)
(display"Fraccion (3/-4) \n")
(define r3 (make-rat 3 -4))  ; -3/4
(print-rat r3);
(car r3);-3
(cdr r3);4
(newline)
(display"Fraccion (-3/-4) \n")
(define r4 (make-rat -3 -4)) ; 3/4
(print-rat r4);
(car r4);3
(cdr r4);4
(display"\n")
