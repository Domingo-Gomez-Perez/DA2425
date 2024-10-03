#lang racket

; Exercise 1.1

; What is the result printed by the interpreter in response to each expression?
; Assume that the sequence is to be evaluated in the order in which it is presented.

10
; 10

(+ 5 3 4)
; (+ 8 4)
; 12

(- 9 1)
; 8

(/ 6 2)
; 3

(+ (* 2 4) (- 4 6))
; (+ 8 (- 4 6))
; (+ 8 -2)
; 6

(define a 3)
; a = 3

(define b (+ a 1))
; b = (+ a 1)
; b = (+ 3 1)
; b = 4

(+ a b (* a b))
; (+ a b (* a b))
; (+ 3 4 (* 3 4))
; (+ 3 4 12)
; (+ 7 12)
; 19

(= a b)
; (= 3 4)
; false

(if (and (> b a) (< b (* a b)))
    b
    a)
; (if (and (> 4 3) (< b (* a b))) b a)
; (if (and true (< b (* a b))) b a)
; (if (and true (< 4 (* 3 4))) b a)
; (if (and true (< 4 12)) b a)
; (if (and true true) b a)
; (if (true) b a)
; (if (true) 4 a)
; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; (cond ((= 3 4) 6)
;       ((= b 4) (+ 6 7 a))
;       (else 25))

; (cond ((false) 6)
;       ((= 4 4) (+ 6 7 a))
;       (else 25))

; (cond ((false) 6)
;       ((true) (+ 6 7 3))
;       (else 25))

; (cond ((false) 6)
;       ((true) (+ 13 3))
;       (else 25))

; (cond ((false) 6)
;       ((true) 16)
;       (else 25))

; 16

(+ 2 (if (> b a) b a))
; (+ 2 (if (> 4 3) b a))
; (+ 2 (if (true) b a))
; (+ 2 (if (true) 4 a))
; (+ 2 4)
; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
; (* (cond ((> 3 4) a)
;          ((< a b) b)
;          (else -1))
;    (+ a 1))

; (* (cond ((false) a)
;          ((< 3 4) b)
;          (else -1))
;    (+ a 1))

; (* (cond ((false) a)
;          ((true) 4)
;          (else -1))
;    (+ a 1))

; (* 4 (+ 3 1))
; (* 4 4)
; 16