#lang racket

; Observe that our model of evaluation allows for
; combinations whose operators are compound expressions.  Use this
; observation to describe the behavior of the following procedure:

; ```
; (define (a-plus-abs-b a b)
;   ((if (> b 0) + -) a b))
; ```

;RESPUESTA: Este procedimiento busca sumar el valor de a con el valor absoluto de b.
; Si b es mayor que 0, entonces se suma a con b. Si b es menor que 0, se le resta b a a. 
; EN este segundo caso se estaría cambiando el signo del valor de b, pasando de negativo
; a positivo, obteniendo en cualquiera de los dos casos "a + abs(b)"