#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
Exercise 1.6: Alyssa P. Hacker doesn't see why if needs to be provided as a special form. 
"Why can't I just define it as an ordinary procedure in terms of cond" she asks. 
Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if:

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5)
; => 5
; Explanation: Since (= 2 3) is false, the `else` clause is evaluated, which is 5.

(new-if (= 1 1) 0 5)
; => 0
; Explanation: Since (= 1 1) is true, the `then` clause is evaluated, which is 0.

Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

What happens when Alyssa attempts to use this to compute square roots?
|#


;RESPUESTA

#|
El problema con el uso de `new-if` en este contexto es que está definido en orden aplicativo, 
lo que significa que evalúa la expresión de la condición y luego decide qué cláusula ejecutar 
basándose en el resultado de esa evaluación. En cambio, el `if` definido en el lenguaje de Racket 
utiliza orden normal, es decir, solo evalúa las cláusulas que realmente necesita.

Para `sqrt-iter`, esto implica que:
- Si `good-enough?` devuelve `#f`, la cláusula `else` `(sqrt-iter (improve guess x) x)` 
  se evaluará, lo que puede llevar a recursión infinita si `good-enough?` nunca devuelve `#t`.
- La recursión seguirá sin fin sin alcanzar un caso base, lo que puede resultar en un 
  desbordamiento de pila.
|#

