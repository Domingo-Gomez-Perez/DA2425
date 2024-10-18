#lang racket

(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n-sign (if (< d 0) (- (/ n g)) (/ n g))) ; Si el denominador es negativo, cambiar el signo del numerador.
          (d-sign (abs (/ d g)))); Asegurar que el denominador siempre sea positivo.
      (cons n-sign d-sign)))); Retornar numerador con signo y denominador positivo.

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define one-half (make-rat 1 2))

(define one-third (make-rat 1 -3))

(print-rat 
 (add-rat one-third one-third))

(print-rat
 (mul-rat one-half one-third))

