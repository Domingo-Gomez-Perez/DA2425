#lang racket

; Exercise 2.2

; Consider the problem of representing line segments in a plane. Each segment is represented as a pair
; of points: a starting point and an ending point. Define a constructor `make-segment` and selectors 
; `start-segment` and `end-segment` that define the representation of segments in terms of points.

; Furthermore, a point can be represented as a pair of numbers: the `x` coordinate and the `y` coordinate.

; Accordingly, specify a constructor `make-point` and selectors `x-point` and `y-point` that define this 
; representation. Finally, using your selectors and constructors, define a procedure `midpoint-segment` 
; that takes a line segment as argument and returns its midpoint (the point whose coordinates are the 
; average of the coordinates of the endpoints). To try your procedures, you'll need a way to print points:


; Point contructor
(define (make-point x y)
  (cons x y))

; Point selectors
(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))


; Segment constructor
(define (make-segment p1 p2)
  (cons p1 p2))

; Segment selectors
(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))


; Final method
(define (midpoint-segment s)
  (define p1-x (x-point (start-segment s)))
  (define p1-y (y-point (start-segment s)))
  (define p2-x (x-point (end-segment s)))
  (define p2-y (y-point (end-segment s)))
  
  (make-point (avg p1-x p2-x) (avg p1-y p2-y)))


; Auxiliar methods
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


(define (print-segment s)
  (newline)
  (display "[")
      (display "(")
      (display (x-point (start-segment s)))
      (display ",")
      (display (y-point (start-segment s)))
      (display ")")
  (display ";")
      (display "(")
      (display (x-point (end-segment s)))
      (display ",")
      (display (y-point (end-segment s)))
      (display ")")
  (display "]"))


(define (avg a b)
  (/ (+ a b) 2))


; Tests

(define point1 (make-point -6 4))
(define point2 (make-point 6 8))
(define segment1 (make-segment point1 point2))

(print-point point1)
(print-point point2)
(print-segment segment1)

(print-point (midpoint-segment segment1))
