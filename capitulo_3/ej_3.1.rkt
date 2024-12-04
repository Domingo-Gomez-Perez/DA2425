#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.1: An accumulator is a procedure that is called repeatedly with a single numeric argument
and accumulates its arguments into a sum. Each time it is called, it returns the currently accumulated sum.
Write a procedure make-accumulator that generates accumulators, each maintaining an independent sum.
The input to make-accumulator should specify the initial value of the sum
; for example

(define A (make-accumulator 5))

(A 10)
15

(A 10)
25
|#

(define (make-accumulator n)

  ; Definimos la función 'incr' que recibe un valor y lo suma al acumulado.
  (define (incr value)
    (begin
      (set! n (+ n value)) ; Se incrementa la suma con el nuevo valor
      n)) ; Retorna el valor acumulado

  ; La función 'make-accumulator' devuelve la función 'incr', que puede ser llamada repetidamente
  incr)

; Pruebas de la funcionalidad

; Creamos un acumulador con un valor inicial de 5.
(define A (make-accumulator 5))

; Llamamos al acumulador con el valor 10. El valor acumulado es ahora 15.
(display (A 10)) ; -> 15
(newline)

; Llamamos de nuevo al acumulador con el valor 10. El valor acumulado es ahora 25.
(display (A 10)) ; -> 25
(newline)
