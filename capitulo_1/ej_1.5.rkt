#lang racket

;Exercise 1.5: Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation 
;or normal-order evaluation. He defines the following two procedures:

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

;Then he evaluates the expression

(test 0 (p))

;What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter 
;that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter 
;is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)

;RESPUESTA:

; Estos dos procedimientos nos sirven para conocer si el interprete que estamos usando usan orden aplicativo o un orden normal de la siguiente manera:
; El primer procedimiento entra en un bucle infinito, porque que no hay ninguna condicion de parada, y
; el segundo procedimiento es una condicional para ver si el primer argumento es 0 y si se cumple la condición devuelve 0, en caso contrario devuelve el segundo argumento.
; Luego con la expresión (test 0 (p)), un interprete que usase un orden aplicativo deberia evaluar las dos variables primero, y tras evaluar (p), entraria en un bucle infinito.
; En cambio, si el interprete usase un orden normal de evaluacion, no evaluaria las variables hasta que no sean necesarias.
; Para este caso, en el que que para la condicion del if no evalua el argumento "(p)" ,  no habria bucle infinito y el procedimiento deberia acabar mostrando por pantalla "0"