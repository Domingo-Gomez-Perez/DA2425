#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.16: Ben Bitdiddle decides to write a procedure to count the number of pairs in any list structure.
"It's easy," he reasons. "The number of pairs in any structure is the number in the car plus the number
in the cdr plus one more to count the current pair." So Ben writes the following procedure (modified for Racket):

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

Show that this procedure is not correct. In particular, draw box-and-pointer diagrams representing list
 structures made up of exactly three pairs for which Ben's procedure would return 3; return 4; return 7;
  never return at all. Encode these diagrams as data structures using Racket mcons.
|#

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))


; Para demostrar que el procedimiento count-pairs propuesto por Ben Bitdiddle no es correcto, 
; necesitamos examinar diferentes casos de estructuras de listas y ver cómo el procedimiento 
; se comporta en cada uno de ellos.

; Caso 1: Lista de tres pares (Debería devolver 3, pero devuelve 4)
; (define lista1 (cons 'a (cons 'b (cons 'c '()))))
(define lista1 (list 'a 'b 'c))
(display (count-pairs lista1)) ; Debería devolver 3 (pero da 4)

; La lista tiene 3 pares: (a . (b . (c . '()))).
; La función count-pairs debe devolver 3, pero debido a cómo se suman las llamadas recursivas, 
; devuelve 4. un valor incorrecto.

; Caso 3: Lista circular (Nunca terminará)
; Esta lista es circular, ya que el cdr de la última pareja apunta de nuevo a la primera.
; La función count-pairs no tiene un caso base adecuado para detectar listas circulares, lo que provoca 
; una recursión infinita y hace que la función nunca termine.