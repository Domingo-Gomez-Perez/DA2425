#lang racket
;Consider the problem of representing line segments in a plane. Each segment is represented as a pair of points: a starting point and an ending point.
;Define a constructor make-segment and selectors start-segment and end-segment that define the representation of segments in terms of points.
;Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate.
;Accordingly, specify a constructor make-point and selectors x-point and y-point that define this representation.
;Finally, using your selectors and constructors, define a procedure midpoint-segment that takes a line segment as argument and returns its midpoint
;(the point whose coordinates are the average of the coordinates of the endpoints). To try your procedures, you'll need a way to print points:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-point x y) (cons x y))

(define (make-segment puntoInicial puntoFinal) (cons puntoInicial puntoFinal))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

;Tenemos que hacer x1+x2/2 , y1+y2/2
(define (midpoint-segment segment) (make-point
                                    (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
                                    (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

;EJEMPLO DE PRUEBA
(define punto1 (make-point 1 3))
(define punto2 (make-point 2 6))

(define segmento (make-segment punto1 punto2))

(define p (midpoint-segment segmento))

(print-point p)
