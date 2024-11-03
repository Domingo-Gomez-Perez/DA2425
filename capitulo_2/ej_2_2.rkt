#lang racket

#|

**Exercise 2.2:** Consider the problem of
representing line segments in a plane.  Each segment is represented as a pair
of points: a starting point and an ending point.  Define a constructor
`make-segment` and selectors `start-segment` and `end-segment`
that define the representation of segments in terms of points.  Furthermore, a
point can be represented as a pair of numbers: the `x` coordinate and the
`y` coordinate.  Accordingly, specify a constructor `make-point` and
selectors `x-point` and `y-point` that define this representation.
Finally, using your selectors and constructors, define a procedure
`midpoint-segment` that takes a line segment as argument and returns its
midpoint (the point whose coordinates are the average of the coordinates of the
endpoints).  To try your procedures, you'll need a way to print points:

```
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
```
|#

(define (make-segment inicio-segmento final-segmento)
  (cons inicio-segmento final-segmento))

(define (start-segment segmento)
  (car segmento)) ;

(define (end-segment segmento)
  (cdr segmento)) ;

(define (make-point x y)
  (cons x y))

(define (x-point punto) 
  (car punto)) ;

(define (y-point punto)
  (cdr punto)) ;

(define (midpoint-segment segmento)
  (let ((inicio (start-segment segmento))
        (final (end-segment segmento)))
    (make-point
     (/ (+ (x-point inicio) (x-point final)) 2)
     (/ (+ (y-point inicio) (y-point final)) 2))))



(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define punto-inicial (make-point 2 4))
(define punto-final (make-point 6 8))

(define segmento (make-segment punto-inicial punto-final))

(define punto-medio (midpoint-segment segmento))

(print-point punto-medio)
