#lang racket

; **Exercise 1.34:** Suppose we define the procedure

; ```
; (define (f g) (g 2))
; ```

; Then we have

; ```
; (f square)
; 4

; (f (lambda (z) (* z (+ z 1))))
; 6
; ```

; What happens if we (perversely) ask the interpreter to evaluate the combination
; `(f f)`?  Explain.

(define (square x) (* x x))
(define (f g) (g 2))
(f square)
(f (lambda (z) (* z (+ z 1))))
(f f) 

; Error obtenido:

; application: not a procedure;
;  expected a procedure that can be applied to arguments
;   given: 2
;   context...:


; RESPUESTA:
; Este error se debe a que estamos intentando pasar una función que no está diseñada
; para manejar números directamente como su propio argumento, lo que lleva a una 
; confusión en la interpretación del programa y termina en un fallo en tiempo de ejecución.