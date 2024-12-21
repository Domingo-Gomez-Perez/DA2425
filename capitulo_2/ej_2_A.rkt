#lang racket

;BOB te da un punto y luego el width y height
(define (make-box-bob x y w h)
  (cons (cons x y) (cons w h)))

(define (width-bob box)
   (car (cdr box)))

(define (height-bob box)
   (cdr (cdr box)))

(define (area-bob box)
    (* (width-bob box) (height-bob box)))

;Alice da dos puntos
(define (make-box-alice x1 y1 x2 y2)
 (cons (cons x1 y1) (cons x2 y2)))

(define (width-alice box)
   (abs (- (car (cdr box))
           (car (car box)))))

(define (height-alice box)
   (abs (- (cdr (cdr box))
           (cdr (car box)))))

(define (area-alice box)
    (* (width-alice box) (height-alice box)))
;-----------------------------------------------------
;|                   Ejercicio 2.A                    |
;------------------------------------------------------
(define a (make-box-alice 1 2 3 4))
(define b (make-box-bob 1 2 3 4))
(area-alice a);4
(area-bob b);12
a ;'((1 . 2) 3 . 4)
b ;'((1 . 2) 3 . 4)
