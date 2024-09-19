#lang racket

; Ejercicio 1

10
;10

(+ 5 3 4)
;12

(- 9 1)
;8
(/ 6 2)
;3

(+ (* 2 4) (- 4 6))
;(+ 8 (- 4  6))
; (+ 8 2)
; 10

(define a 3)
;a = 3

(define b (+ a 1))
;(define b (+ 3 1))
;(define b 4)
;b = 4

(+ a b (* a b))
;(+ 3 4 (* 3 4))
;(+ 3 4 12)
; 19

(= a b)
;(= 3 4)
;#f

(if (and (> b a) (< b (* a b)))
    b
    a)

;(if (and (> 4 3) (< b (* a b)))
;    b
;    a)

;(if (and (#t) (< b (* a b)))
;    b
;    a)

;(if (and (#t) (< 4 (* 3 4)))
;    b
;    a)


;(if (and (#t) (< 4 12))
;    b
;    a)

;(if (and #t #f))
;    b
;    a)

; a

; 3

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

;(cond ((= 3 4) 6)
;      ((= b 4) (+ 6 7 a))
;      (else 25))

;(cond ((#f) 6)
;      ((= b 4) (+ 6 7 a))
;      (else 25))

;(cond ((= 4 4) (+ 6 7 a))
;      (else 25))

;(cond (#t (+ 6 7 a))
;      (else 25))

; (+ 6 7 3)

; 16

(+ 2 (if (> b a) b a))

; (+ 2 (if (> 4 3) b a))
; (+ 2 (if (#t) b a))
; (+ 2  b )
; (+ 2  4 )
; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

;(* (cond ((> 3 4) a)
;         ((< a b) b)
;         (else -1))
;   (+ a 1))

;(* (cond ((#f) a)
;         ((< a b) b)
;         (else -1))
;   (+ a 1))


;(* (cond ((< 3 4) b)
;         (else -1))
;   (+ a 1))

;(* (cond (#t) b)
;         (else -1))
;   (+ a 1))

;(* 4 (+ a 1))

;(* 4 (+ 3 1))

; (* 4  4)

;16

