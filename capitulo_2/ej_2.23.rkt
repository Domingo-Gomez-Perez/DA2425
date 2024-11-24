#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.23: The procedure for-each is similar to map. It takes as arguments a
procedure and a list of elements. However, rather than forming a list of the results,
for-each just applies the procedure to each of the elements in turn, from left to right.
The values returned by applying the procedure to the elements are not used at all---for-each
is used with procedures that perform an action, such as printing. For example,

(for-each
 (lambda (x) (newline) (display x))
 (list 57 321 88))

57
321
88

The value returned by the call to for-each (not illustrated above) can be something
arbitrary, such as true. Give an implementation of for-each.
|#

; hace lo mismo que el map pero va poniendo cada cosa por separado
; como devolver algo cuando acaba la lista, devolvera void para que no cause errores
; ademas podemos usar begin para que haga varias cosas a la vez

(define (for-each proc lst)
  (if (null? lst)
      (void)  ; devolvemos void para que no influya al pintar
      (begin ; usamos begin para que haga las dos cosas que necesitamos
        (proc (car lst)) ; aplicamos proc al elemento que estamos
        (for-each proc (cdr lst))))) ; vamos recursivamente al siguiente

; con begin queda mas ordenado que creando con let una variable y aplicando

; pruebas
(for-each (lambda (x) (newline) (display x)) (list 57 321 88)) ; => 57 321 88