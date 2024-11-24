#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.2: Consider the problem of representing line segments in a plane.
Each segment is represented as a pair of points: a starting point and an
ending point. Define a constructor make-segment and selectors start-segment
and end-segment that define the representation of segments in terms of points.
Furthermore, a point can be represented as a pair of numbers: the x coordinate
and the y coordinate. Accordingly, specify a constructor make-point and
selectors x-point and y-point that define this representation. Finally, using
your selectors and constructors, define a procedure midpoint-segment that takes
a line segment as argument and returns its midpoint (the point whose coordinates
are the average of the coordinates of the endpoints). To try your procedures,
you'll need a way to print points:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
|#

; la de print que nos dan
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;----------------------------------------------------------------
; el punto esta compuesto de dos coordenadas
(define (make-point x y)
  (cons x y))

; la x y la y del punto son la parte izquierda y derecha del cons
(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;----------------------------------------------------------------
; el segmento esta compuesto de dos puntos
(define (make-segment start end)
  (cons start end))

; el inicio y fin del segmento son la parte izquierda y derecha del cons
(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;----------------------------------------------------------------
; ahora hay que calcular el punto medio, para ello hay que sumar cada
; coordenada y dividir entre 2 (hacer la media de cada una)
(define (midpoint-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (make-point (/ (+ (x-point start) (x-point end)) 2) (/ (+ (y-point start) (y-point end)) 2))))

; pruebas:
(define p1 (make-point 0 0))
(define p2 (make-point 2 2))
(define segment (make-segment p1 p2))

(print-point (midpoint-segment segment)) ; debería dar el punto (1,1)
