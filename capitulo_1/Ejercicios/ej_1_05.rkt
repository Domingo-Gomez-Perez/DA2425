#lang racket
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))

; En la evaluación por orden aplicativo, los argumentos de una función se evalúan antes de que la función sea aplicada.
; Al evaluar (test 0 (p)), el intérprete intenta primero evaluar (p), pero como (p) se llama a sí mismo recursivamente, esto resulta en una recursión infinita.
; Por lo tanto, el intérprete nunca llega a evaluar la expresión if y se quedará en un bucle infinito.

; En la evaluación por orden normal, los argumentos de una función no se evalúan hasta que realmente se necesiten.
; Al evaluar (test 0 (p)) en orden normal, el intérprete primero evalúa la condición x = 0.
; Como x = 0 es verdadero, la función devuelve 0 sin evaluar nunca (p), por lo que no ocurre recursión infinita.

; En resumen, en este caso en la evaluación por orden aplicativo se llega a un bucle infinito y mediante orden normal se devuelve 0