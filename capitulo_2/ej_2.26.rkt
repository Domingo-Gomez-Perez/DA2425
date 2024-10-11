#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.26: Suppose we define x and y to be two lists:

(define x (list 1 2 3))
(define y (list 4 5 6))

What result is printed by the interpreter in response to evaluating each of the 
following expressions:

(append x y)
(cons x y)
(list x y)
|#

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)     ;=> arroja '(1 2 3 4 5 6) ya que append combina dos listas en una sola lista, tomando los elementos de la primera lista y los añade al final de la segunda lista.
(cons x y)       ;=> arroja '((1 2 3) 4 5 6) ya que la sintaxis de cons es (cons elemento lista), por lo que toma x como un solo elemento
(list x y)       ;=> arroja '((1 2 3) (4 5 6)) ya que list crea una nueva lista a partir de sus argumentos sin concatenar las listas, porque que las considera como elementos individuales.
