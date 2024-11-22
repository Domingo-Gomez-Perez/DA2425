#lang racket
;Ejercicio 2.6

;; Definiciones previas
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; Numerales de Church
(define one (lambda (f) (lambda (x) (f x)))) 
(define two (lambda (f) (lambda (x) (f (f x)))))  

;; Procedimiento de suma de Church numerals
(define (suma x y)
  (lambda (f) (lambda (z) ((x f) ((y f) z)))))

;; Test 1: one + zero = one
(define test1 ((suma one zero) (lambda (x) (+ x 1)))) ;; (one + zero)
(display (test1 0))  ;; Aplicamos la función de incremento a 0
(newline)  ;; Debería mostrar 1