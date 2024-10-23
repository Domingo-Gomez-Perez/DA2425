#lang racket

; Challenge Exercise

; In Exercise 2.6, the Church numerals were defined.
; If `x` and `y` are Church numerals, can you define subtraction?

; Returns a procedure representing x - y

(define (sub-1 n)
  (lambda (f)
    (lambda (x)
      (((n (lambda (g) (lambda (h) (h (g f))))) (lambda (u) x)) (lambda (u) u))
 )))


(define (sub x y)
  ((y sub-1) x))



; Auxiliar methods
(define (church-add n1 n2)
  (lambda (f)
    (lambda (x)
      ((n1 f) ((n2 f) x)))))

; To convert Church numerals to regular numbers for testing
(define (church-to-int n)
  ((n (lambda (x) (+ x 1))) 0))


; Tests
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (church-add one two))
(define six (church-add three three))

(define four (sub six two)) ; Sub 6-2 = 4
(define five (sub-1 six))   ; Sub 6-1 = 5


(church-to-int one)  ; should return 1
(church-to-int two)  ; should return 2
(church-to-int three); should return 3
(church-to-int four) ; should return 4
(church-to-int five) ; should return 5
(church-to-int six)  ; should return 6