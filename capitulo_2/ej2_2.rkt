#lang racket



; **Exercise 2.2:** Consider the problem of
; representing line segments in a plane.  Each segment is represented as a pair
; of points: a starting point and an ending point.  Define a constructor
; `make-segment` and selectors `start-segment` and `end-segment`
; that define the representation of segments in terms of points.  Furthermore, a
; point can be represented as a pair of numbers: the `x` coordinate and the
; `y` coordinate.  Accordingly, specify a constructor `make-point` and
; selectors `x-point` and `y-point` that define this representation.
; Finally, using your selectors and constructors, define a procedure
; `midpoint-segment` that takes a line segment as argument and returns its
; midpoint (the point whose coordinates are the average of the coordinates of the
; endpoints).  To try your procedures, you'll need a way to print points:

; ```
; (define (print-point p)
;   (newline)
;   (display "(")
;   (display (x-point p))
;   (display ",")
;   (display (y-point p))
;   (display ")"))
; ```

;; Constructor para un punto
(define (make-point x y)
  (cons x y))

;; Selectores para obtener las coordenadas x e y de un punto
(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;; Constructor para un segmento
(define (make-segment start end)
  (cons start end))

;; Selectores para obtener el punto de inicio y el punto final de un segmento
(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;; Función para calcular el punto medio de un segmento
(define (midpoint-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (make-point
     (/ (+ (x-point start) (x-point end)) 2)
     (/ (+ (y-point start) (y-point end)) 2))))

;; Función para imprimir un punto
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; Ejemplo de uso
(define p1 (make-point 0 0))
(define p2 (make-point 4 5))
(define segment (make-segment p1 p2))

(print-point (midpoint-segment segment))


