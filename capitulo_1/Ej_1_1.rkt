#lang racket

10
; 10

(+ 5 3 4)
; 5+3+4 = 12

(- 9 1)
; 9-1=8

(/ 6 2)
; 6/2=3

(+ (* 2 4) (- 4 6))
; (2*4)+(4-6)=6

(define a 3)
; a = 3

(define b (+ a 1))
; b = a+1 = 3+1 = 4

(+ a b (* a b))
; a+b+(a*b)=3+4+(3*4)=19

(= a b)
; a==b => #f

(if (and (> b a) (< b (* a b)))
    b
    a)
; (if (and #t #t) b a)
; (if (#t) b a)
; El and es true, por lo que sale b, es decir, 4
    
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; (cond ((#f) 6)
;       ((#t) 16)
;       (else 25))
; segunda condicion, 16
      
(+ 2 (if (> b a) b a))
; (+ 2 (if (#t) b a))
; (+ 2 b)
; 6, el if es true

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
; (* (cond ((#f) a) ((#t) b) (else -1)) 4)
; (* b 4)
; 4 * 4= 16