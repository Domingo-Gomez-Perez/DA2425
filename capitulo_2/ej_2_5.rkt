#lang racket

(define (cons3 a b)
  (* (expt 2 a) (expt 3 b)))


(define (car3 z)
  (define (count-factors n factor)
    (if (= (remainder n factor) 0)
        (+ 1 (count-factors (/ n factor) factor))
        0))
  (count-factors z 2))


(define (cdr3 z)
  (define (count-factors n factor)
    (if (= (remainder n factor) 0)
        (+ 1 (count-factors (/ n factor) factor))
        0))
  (count-factors z 3))


; Demostracion
(define pareja1 (cons3 2 6))

(cons3 2 6) ; Deberia devolver 2^a * 3^b = 2^2 * 3^6 = 2916

(car3 pareja1) ; Deberia recuperar a = 2 --> 2^2

(cdr3 pareja1) ; Deberia recuperar b = 6 --> 3^6