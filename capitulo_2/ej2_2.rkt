#lang racket
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

(print-point puntoF) ;(5/2,4)