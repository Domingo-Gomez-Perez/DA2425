#lang racket

#|
**Exercise 1.42:** Let `f` and `g` be two
one-argument functions.  The composition `f` after `g` is defined
to be the function that maps `x` to `f(g(x))`.  Define a procedure
`compose` that implements composition.  For example, if `inc` is a
procedure that adds 1 to its argument,

```
((compose square inc) 6)    ; -> 49
```
|#


(define (compose f g)
  (lambda (x) (f(g x))))

(define (square n) (* n n))
(define (inc n) (+ n 1))

((compose square inc) 6)

#|
Una manera de hacer composición de funciones como el hecho en el ejercicio anterior es definir una función compose
que tiene 2 argumentos que son 2 funciones y que ambas tienen 1 argumento. Para ello, uso una función lambda que tiene
un argumento "x" que lo que hace es aplicar la función "g" con respecto a su argumento x, y el resultado de esta función será
el argumento de la función "f" que devolverá un resultado. Entonces, el valor de esta composición de funciones será el que se muestre.

En este caso, primero se aplica la función "inc" al valor 6 (7) y a este resultado se le aplica la función "square" que sería 49.
|#