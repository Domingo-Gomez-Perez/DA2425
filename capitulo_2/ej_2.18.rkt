#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.18: Define a procedure reverse that takes a list as argument and
returns a list of the same elements in reverse order:

(reverse (list 1 4 9 16 25))
; => '(25 16 9 4 1)

Bonus: Can you design an algorithm that requires only n steps for a list containing n items?
|#

; hay dos opciones, un procedimiento recursivo y uno iterativo.
; el recursivo llegará a crearla en 2n y el iterativo en n
; ya que el recursivo debe ir hasta el final y luego volver y el iterativo puede empezar desde el final

; Versión recursiva para revertir una lista
; vamos a usar append ya que simplifica mucho anhadir a listas

(define (reverse lst)
  (if (null? lst) ; cuando llegamos al final acabamos
      '()
      (append (reverse (cdr lst)) (list (car lst))))) ; ponemos el primer elemento de la lista al final y vamos poniendo cada vez uno

; ahora la version iterativa (el bonus)
(define (reverse-iter lst)
  (define (reverse-iter-cap lst result)
    (if (null? lst)
        result ; si hemos llegado a null es que hemos recorrido toda la lista
        (reverse-iter-cap (cdr lst) (cons (car lst) result)))) ; va poniendo al reves en la lista

  (reverse-iter-cap lst '())) ; empezamos mandando una lista vacia

; pruebas
(reverse (list 1 4 9 16 25)) ; => '(25 16 9 4 1)
(reverse-iter (list 1 4 9 16 25)) ; => '(25 16 9 4 1)
