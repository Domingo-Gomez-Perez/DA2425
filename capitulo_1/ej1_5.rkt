#lang racket

; Ben Bitdiddle has invented a test to determine whether
; the interpreter he is faced with is using applicative-order evaluation
; or normal-order evaluation.  He defines the following two procedures:

; ```
; (define (p) (p))

; (define (test x y) 
;   (if (= x 0) 
;       0 
;       y))
; ```

; Then he evaluates the expression

; ```
; (test 0 (p))
; ```

; What behavior will Ben observe with an interpreter that uses applicative-order
; evaluation?  What behavior will he observe with an interpreter that uses
; normal-order evaluation?  Explain your answer.  (Assume that the evaluation
; rule for the special form `if` is the same whether the interpreter is
; using normal or applicative order: The predicate expression is evaluated first,
; and the result determines whether to evaluate the consequent or the alternative
; expression.)

;RESPUESTA: Si se usara un orden aplicativo, sucederia que al intentar llamar a la funcion
;llamada "p" se entraría en un bucle infinito, ya que se le asignaria ella misma indefinidamente.
;Si se usara un orden normal, la funcion "test" simplemente devolvería 0, pues en la propia funcion
;"test" se evalua la condicion y se determina que se debe devolver 0 antes de necesitar operar
;con el argumento de entrada "p" (que es el que da problemas en el orden aplicativo.