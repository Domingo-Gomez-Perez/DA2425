#lang racket

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-segment start-point end-point)
  (cons start-point end-point))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
              (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

(define (print-point p)
  (display (x-point p))
  (display ",")
  (display (y-point p)))

(define p1 (make-point 0 0))
(define p2 (make-point 2 2))
(define segmento (make-segment p1 p2))
(define punto_medio (midpoint-segment segmento))
(print-point punto_medio)