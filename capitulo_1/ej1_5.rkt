#lang racket
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))


; 1. Evaluación por orden aplicativo:
; En la evaluación por orden aplicativo, los argumentos de una función se evalúan antes de que la función sea llamada. Al evaluar (test 0 (p)):

; x = 0 se evalúa normalmente.
; y = (p) intenta evaluar la expresión (p), pero como p se define como (define (p) (p)), esto causa una recursión infinita.
; Por lo tanto, con evaluación por orden aplicativo, el intérprete entrará en un bucle infinito al intentar evaluar (p) y nunca terminará.

; 2. Evaluación por orden normal:
; En la evaluación por orden normal, los argumentos de una función no se evalúan hasta que son necesarios. Al evaluar (test 0 (p)):

; x = 0 es evaluado.
; La expresión if (= x 0) es verdadera, por lo que el if retorna 0 sin evaluar y = (p).
; Con evaluación por orden normal, el intérprete retornará 0, ya que nunca necesita evaluar (p), evitando así la recursión infinita.
