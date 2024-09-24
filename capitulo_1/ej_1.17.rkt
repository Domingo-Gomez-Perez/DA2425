#lang racket
;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.17: Los algoritmos de exponenciación de esta sección se basan en realizar
la exponenciación mediante multiplicaciones repetidas. De manera similar, se puede realizar
la multiplicación de números enteros mediante sumas repetidas.
El siguiente procedimiento de multiplicación (en el que se supone que nuestro lenguaje solo puede sumar, no multiplicar)
es análogo al exptprocedimiento:

(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

Este algoritmo requiere una cantidad de pasos lineal en b. Ahora supongamos que incluimos,
junto con la suma, las operaciones double, que duplica un entero, y halve, que divide un entero (par) por 2.
Con estas operaciones, diseñe un procedimiento de multiplicación análogo a fast-expt que utilice una
cantidad logarítmica de pasos.
|#

; Iterative version of fast-mul
(define (double x) (* 2 x)) ; Doubles x
(define (halve x) (/ x 2)); Divides x by 2

(define (fast-mul a b)
  (cond ((= b 0) 0) ; If b is 0, return 0
        ((even? b) (fast-mul (double a) (halve b))) ; If b is even, then the algorithm uses
                                                    ; the halve function to reduce the number of b's iterations
        ((odd? b) (+ (fast-mul a (- b 1)) a))))     ; If b is odd, then the algorithm subtracts 1 from b to convert it to even


