#lang racket

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))


;Si el orden es aplicativo se evaluaran todas las variables por lo que el valor p se interpretara y al ser no valido la operación no da resultado.
;Con un orden normal no se evalua p si el primer argumento de test es 0, ya que no esta en ninguna operación interna de test por lo que daria
;un 0 como resultado

;En este entorno el orden es aplicativo ya que no da resultado la operación.
