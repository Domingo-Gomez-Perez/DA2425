#lang racket
(define (p)  (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

;En la primera función se quedará "atascado" haciendo todo el rato lo mismo en bucle.
;En la segunda se evaluará la condición y dependiendo de si se cumple se asigna  "0" o "y" si no se cumple.
;El comportamiento que observará Ben al intentar evaluar la expresión (test 0 (p)) es el siguiente:
;- Si en intérprete que usa orden aplicativo primero evaluaría el primer argumento y al intentar evaluar el segundo se quedaría atascado.
;- Si el intérprete usa orden normal obtendríamos un 0 como resultado ya que primero se evalua la condicion, que se cumple, no necesita evaluar p.