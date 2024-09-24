#lang racket

;Tiene orden aplicativo puesto que no sale del bucle ya que se queda
; todo el rato evaluando los argumentos y como uno de ellos es un bucle
; infinito por eso se queda ahí.
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))