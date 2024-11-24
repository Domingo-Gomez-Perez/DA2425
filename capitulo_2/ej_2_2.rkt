#lang racket
;Ejercicio 2.2

(define (make-point x y) (cons x y))

(define (x-point p) (car p))
(define (y-point p) (cdr p))


(define (make-segment i f) (cons i f))

(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
  (let ((x1 (x-point (start-segment s)))
        (x2 (x-point (end-segment s)))
        (y1 (y-point (start-segment s)))
        (y2 (y-point (end-segment s))))
    (make-point (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define i (make-point 2 1))
(define f (make-point 4 3))
(define s (make-segment i f))

(print-point (midpoint-segment s))

