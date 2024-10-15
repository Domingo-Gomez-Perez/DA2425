#lang racket
; constructor segmento
(define (make-segment start-segment end-segment)
  (cons start-segment end-segment))

; selectores
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))

; constructor punto
(define (make-point x-point y-point)
  (cons x-point y-point))

; selectores
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

; media
(define (average x y)
  (/ (+ x y) 2))

; punto medio
(define (midpoint-segment segment)
  (define start-x-point (x-point (start-segment segment)))
  (define start-y-point (y-point (start-segment segment)))
  (define end-x-point (x-point (end-segment segment)))
  (define end-y-point (y-point (end-segment segment)))
  (make-point (average start-x-point end-x-point) (average start-y-point end-y-point)))

; print
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; comprobar
(define ini (make-point 1 1))
(define fin (make-point 2 4))
(define segment (make-segment ini fin))
(print-point (midpoint-segment segment))
  