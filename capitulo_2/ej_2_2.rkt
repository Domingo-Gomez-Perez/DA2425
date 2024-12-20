#lang racket

;Se obtiene el valor de x
(define (x-point punto)
  (car punto))

;Se obtiene el valor de y
(define (y-point punto)
  (cdr punto))

;Se crea un punto
(define (make-point x-point y-point)
  (cons x-point y-point))

;Se crea un segmento
(define (make-segment start-segment end-segment)
  (cons start-segment end-segment))

;Se calcula el punto medio del segmento
(define (midpoint-segment segment)
  (cons (/ (+ (x-point (car segment)) (x-point (cdr segment))) 2)
        (/ (+ (y-point (car segment)) (y-point (cdr segment))) 2)))

;Se utiliza para sacar por pantalla los valor de p
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;Prueba realizada, sale correctamente
(define p1 (make-point 2 3))
(define p2 (make-point 3 5))
(define segmento (make-segment p1 p2))
(define punto-medio (midpoint-segment segmento))
(print-point punto-medio)

