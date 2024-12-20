#lang racket
;Ejercicio 2.2

(define (make-segment ini fin) (cons ini fin))

(define (start-segment segment) (car segment))

(define (end-segment segment) (cdr segment))

(define (make-point x y) (cons x y))

(define (x-point pto) (car pto))

(define (y-point pto) (cdr pto))

(define (midpoint-segment segment) (
    cons (/ (- (x-point (end-segment segment)) (x-point (start-segment segment))) 2) (/ (- (y-point (end-segment segment)) (y-point (start-segment segment))) 2)
                                    ))

(midpoint-segment (make-segment (make-point 0 0) (make-point 4 4)))