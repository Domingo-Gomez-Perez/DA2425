#lang racket

10
; 10

(+ 5 3 4)
;(+ 8 4)
;12

(- 9 1)
;resta 9-1=8

(/ 6 2)
;divide 6/2=3

(+ (* 2 4) (- 4 6))
;(+ 8 (- 4 6))
;(+ 8 -2)
;6

(define a 3)
;No devuelve nada pero define a como 3

(define b (+ a 1))
;No devuelve nada pero define b como 4

(+ a b (* a b))
;(+ a b 12)
;(+ 7 12)
;19

(= a b)
;#f False

(if (and (> b a) (< b (* a b)))
    b
    a)
;(if (and True True)b a)
;(if (True)b a)
;b

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
;(cond ((False) 6) ((= b 4) (+ 6 7 a)) (else 25))
;(cond ((True) (+ 6 7 a)) (else 25))
;(+ 13 a)
;16

(+ 2 (if (> b a) b a))
;(+ 2 (if (True) b a))
;(+ 2 b)
;6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
;(* (cond ((False) a) ((< a b) b) (else -1)) (+ a 1))
;(* (cond ((True) b) (else -1)) (+ a 1))
;(* b (+ a 1))
;(* b 4)
;12