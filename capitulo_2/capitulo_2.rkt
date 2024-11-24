#lang racket

;EJERCICIO 2.1
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

;EJERCICIO 2.2
; Definimos un punto como un par de números usando cons
(define (make-point x y) (cons x y))              
(define (x-point p) (car p))                       
(define (y-point p) (cdr p))                       
; Definimos un segmento 
(define (make-segment start end) (cons start end)) 
(define (start-segment s) (car s))                 
(define (end-segment s) (cdr s))                   

; Calculamos el punto medio del segmento
(define (midpoint-segment segment)
  (let ((start (start-segment segment))      
        (end (end-segment segment)))         
    (make-point 
      (/ (+ (x-point start) (x-point end)) 2) 
      (/ (+ (y-point start) (y-point end)) 2)))) 

; Creamos dos puntos
(define point1 (make-point 1 2))                
(define point2 (make-point 4 6))                


(define segment (make-segment point1 point2))   

; Calculamos el punto medio del segmento
(define puntoF (midpoint-segment segment))       

; Imprimimos el punto medio calculado
(define (print-point puntoF)
  (newline)
  (display "(")
  (display (x-point puntoF))
  (display ", ")
  (display (y-point puntoF))
  (display ")"))

(print-point puntoF) (5/2, 4)
