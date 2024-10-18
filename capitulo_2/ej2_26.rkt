#lang racket

(define x (list 1 2 3)) 
(define y (list 4 5 6)) 

;Evaluaciones
(define append-result (append x y))   
(define cons-result (cons x y))        
(define list-result (list x y))        

;; Mostrar resultados
(display append-result) (newline)
(display cons-result) (newline)
(display list-result) (newline)


