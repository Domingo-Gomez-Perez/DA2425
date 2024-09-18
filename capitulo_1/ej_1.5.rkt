#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.5: Ben Bitdiddle has invented a test to determine whether the interpreter 
he is faced with is using applicative-order evaluation or normal-order evaluation. 
He defines the following two procedures:

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

Then he evaluates the expression

(test 0 (p))

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? 
What behavior will he observe with an interpreter that uses normal-order evaluation? 
Explain your answer. 
(Assume that the evaluation rule for the special form if is the same whether the interpreter
 is using normal or applicative order: The predicate expression is evaluated first, 
 and the result determines whether to evaluate the consequent or the alternative expression.)
|#

; RESPUESTA

#|
Evaluación en Orden Aplicativa:
Todos los argumentos se evalúan antes de aplicar la función. 
Si un argumento lleva a un bucle infinito, como en (p), el intérprete nunca completa la evaluación y se queda atrapado en el bucle.

Evaluación en Orden Normal:
Los argumentos se evalúan solo cuando son necesarios. 
En (test 0 (p)), la evaluación de la condición (= 0 0) es suficiente para determinar el resultado, por lo que el argumento (p) no se evalúa y el resultado es 0.
|#
