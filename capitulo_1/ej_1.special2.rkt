#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Special Exercise. What answer is given by the following code? Can you explain it?

(define x 5)
(+ (let ((x 3))
        (+ x (* x 10)))
   x)
|#


#|
da 38 como resultado, porque primero define una x global como 5, luego dentro de la suma define una x local como 3, 
y a esa x le aplica una multiplicación por 10, y luego ese resultado lo suma con la misma x local (3), por lo que nos queda 33.
Luego ese resultado lo suma con la x global que es 5, dando como resultado 38.
|#
