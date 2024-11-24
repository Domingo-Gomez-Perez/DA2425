#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.1: Below is a sequence of expressions.
What is the result printed by the interpreter in response to each expression?
Assume that the sequence is to be evaluated in the order in which it is presented.
|#

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
; (+ 8 -2)
; 6

(define a 3)
; a
; 3

(define b (+ a 1))
; (define b (+ 3 1))
; (define b 4)
; b = 4

(+ a b (* a b))
; (+ 3 4 (* 3 4))
; (+ 7 12)
; 19

(= a b)
; (= 3 4)
; #f

(if (and (> b a) (< b (* a b)))
    b
    a)

;  primero el predicate, despues la rama que salga
;  como tiene un and, hay que ir condicion por condicion mirando

; (if (and (> 4 3) (< b (* a b)))
;     b
;     a)

; (if (and #t (< b (* a b)))
;     b
;     a)

; (if (and #t (< 4 (* 3 4)))
;     b
;     a)

; (if (and #t (< 4 12))
;     b
;     a)

; (if (and #t #t)
;     b
;     a)

; (if #t
;     b
;     a)

; b

; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

;  primero el predicate, despues rama por rama

; (cond ((= 3 4) 6)
;       ((= b 4) (+ 6 7 a))
;       (else 25))

; (cond (#f)
;       ((= b 4) (+ 6 7 a))
;       (else 25))

; (cond (#f)
;       ((= 4 4) (+ 6 7 a))
;       (else 25))

; (cond (#f)
;       (#t (+ 6 7 a))
;       (else 25))

; (+ 6 7 a)

; (+ 6 7 3)

; 16

(+ 2 (if (> b a)
         b
         a))
; hay que tener en cuenta el if
; (+ 2 (if (> 4 3)
;          b
;          a))

; (+ 2 (if #t
;          b
;          a))

; (+ 2 b)

; (+ 2 4)

; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

; (* (cond ((> 3 4) a)
;          ((< a b) b)
;          (else -1))
;    (+ 3 1))

; (* (cond (#f a)
;          ((< a b) b)
;          (else -1))
;    4)

; (* (cond (#f a)
;          ((< 3 4) b)
;          (else -1))
;    4)

; (* (cond (#f a)
;          (#t b)
;          (else -1))
;    4)

; (* b 4)

; (* 4 4)

; 16