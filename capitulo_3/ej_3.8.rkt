#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.8: When we defined the evaluation model in 1.1.3, we said that the first step in evaluating
an expression is to evaluate its subexpressions. But we never specified the order in which
the subexpressions should be evaluated (e.g., left to right or right to left). When we introduce assignment,
the order in which the arguments to a procedure are evaluated can make a difference to the result.
Define a simple procedure f such that evaluating

(+ (f 0) (f 1))
will return 0 if the arguments to + are evaluated from left to right but will return 1 if the arguments
are evaluated from right to left.
|#

(define valor 0) ; Definir valor global

(define (f n)
  (cond
    [(and (= n 0) (= valor 0)) 0] ; Si n es 0 y valor es 0, devuelve 0
    [(and (= n 1) (= valor 0)) ; Si n es 1 y valor es 0
     (begin
       (set! valor 1)
       0)] ; establece valor a 1 y devuelve 0
    [(and (= n 0) (= valor 1)) 1] ; Si n es 0 y valor es 1, devuelve 1
    [else 0])) ; Caso por defecto

; Evaluamos las expresiones
(+ (f 0) (f 1)) ; -> Debería devolver 0
(+ (f 1) (f 0)) ; -> Debería devolver 1
