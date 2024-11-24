#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

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
5
|#

; todos los metodos de sqrt-iter

; el principal, parece recursivo pero va iterando cada vez aproximando el x
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

; la funcion de newton de mejorar
(define (improve guess x)
  (average guess (/ x guess)))

; la media
(define (average x y)
  (/ (+ x y) 2))

; el sesgo para determinar que hemos acabado, cuando entre los dos valores no cambia mas de 0.001
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))

; el cuadrado
(define (square x) (* x x))

; encapsulamiento para no tener que poner guess nunca y poder poner solo el numero
(define (sqrt x)
  (sqrt-iter 1.0 x))

; ejemplos de esto antes de redefinir el if
(sqrt 9)
; 3.00009155413138

(sqrt (+ 100 37))
; 11.704699917758145

(sqrt (+ (sqrt 2) (sqrt 3)))
; 1.7739279023207892

(square (sqrt 1000))
; 1000.000369924366

; vemos que todo va bien, ahora cambiemos la definicion del if y luego del sqrt-iter

(define (new-if predicate
                then-clause
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3)
        0
        5)
; 5

(new-if (= 1 1)
        0
        5)
; 0

; parece que todo va bien y parece que es correcto ya que usa cond dentro del if y
; cond tambien se ejecuta en orden normal pero al probarlo con los casos
; que prueban de verdad:

(new-if (= 1 1)
        0
        (/ 0 0))
; 0

; vemos que salta la division por 0 cuando no estamos yendo por esa rama

; al escribir la raiz con esto, puede no dar error en principio.
(define (new-sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (new-sqrt x)
  (new-sqrt-iter 1.0 x))

; ejemplos de esto despues de redefinir el if
(new-sqrt 9)
; 3.00009155413138

(new-sqrt (+ 100 37))
; 11.704699917758145

(new-sqrt (+ (new-sqrt 2) (new-sqrt 3)))
; 1.7739279023207892

(square (new-sqrt 1000))
; 1000.000369924366


#| El problema con el uso de `new-if` en este contexto es que está definido en orden aplicativo,
lo que significa que evalúa la expresión de la condición y luego decide qué cláusula ejecutar
basándose en el resultado de esa evaluación. En cambio, el `if` definido en el lenguaje de Racket
utiliza orden normal, es decir, solo evalúa las cláusulas que realmente necesita.

Para `sqrt-iter`, esto implica que:
Si `good-enough?` devuelve `#f`, la cláusula `else` `(sqrt-iter (improve guess x) x)`
se evaluará, lo que puede llevar a recursión infinita si `good-enough?` nunca devuelve `#t`.
La recursión seguirá sin fin sin alcanzar un caso base, lo que puede resultar en un
desbordamiento de pila. |#

