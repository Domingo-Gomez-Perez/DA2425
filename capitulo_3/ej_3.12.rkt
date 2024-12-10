#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.12: The following procedure for appending lists was introduced in 2.2.1.
It has been modified for use in Racket specifically for this exercise.

(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))

Append forms a new list by successively consing the elements of x onto y.
The procedure append! is similar to append, but it is a mutator rather than a constructor.
It appends the lists by splicing them together, modifying the final pair of x so that its cdr is now y.
(It is an error to call append! with an empty x.)

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

Here last-pair is a procedure that returns the last pair in its argument:

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

Consider the interaction

(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))

z
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(cdr x)
⟨response⟩

(define w (append! x y))

w
(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(cdr x)
⟨response⟩

What are the missing ⟨response⟩s? Draw box-and-pointer diagrams to explain your answer.
|#

; definiciones iniciales para el ejercicio
(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

; datos que definimos:
(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))

z ;-> '(a b c d)

#| Como estamos usando append normal, se devuelve una nueva lista sin modificar las listas originales.

Primer paso:
Se llama a (append x y) con x = (a b) y y = (c d).
La función verifica si x está vacía con (null? x). Como x no está vacía, se pasa a la rama else.
La expresión (car x) es 'a, y (cdr x) es (b). Entonces se hace la llamada recursiva a (append (cdr x) y) que es (append (b) (c d)).

Segundo paso:
Ahora estamos en (append (b) (c d)).
De nuevo, x = (b) no está vacío, por lo que la función toma el car de x que es 'b, y el cdr de x es ().
Se hace una llamada recursiva a (append (cdr (b)) y) que es (append () (c d)).

Tercer paso:
Ahora estamos en (append () (c d)).
En este caso, x es la lista vacía, por lo que la función devuelve simplemente y, es decir, (c d).

Regreso de la recursión:
En el segundo paso, se vuelve de (append (b) (c d)), donde el resultado de la llamada recursiva fue (c d).
Ahora tenemos que hacer (cons 'b (c d)), lo que da como resultado (b c d).

Último paso:
En el primer paso, se vuelve de (append (a b) (c d)), donde el resultado de la llamada recursiva fue (b c d).
Finalmente, se hace (cons 'a (b c d)), lo que da como resultado la lista (a b c d).

x:  [ a ] -> [ b ] -> [ ]
y:  [ c ] -> [ d ] -> [ ]
z:  [ a ] -> [ b ] -> [ c ] -> [ d ] -> [ ]

Lo que se comparte: Los elementos 'a, 'b, 'c, y 'd son los mismos que los de las listas originales,
(no se duplican) pero se organizan en una nueva lista z.

Lo nuevo: z es una nueva lista creada por la función append, que conecta los elementos de x y y
de forma secuencial. Sin embargo, no hay modificaciones a las listas originales x ni y. |#

(mcdr x) ; -> '(b)
; El cdr va a devolver la cola de la lsita de x, es decir: b

(define w (append! x y))

w

#| El procedimiento append! es un mutador que modifica la lista x al cambiar el cdr del último
par de x para que apunte a y. Esta es una operación destructiva que modifica la lista original x.

Se llama a last-pair con x = (a b):
Primero se revisa (cdr x), que es (b), y luego se llama a last-pair con (b).
Se revisa (cdr (b)), que es (), así que devuelve (b), que es el último par.
Luego, se llama a set-cdr! para establecer el cdr del último par (b) como y, es decir, (c d). La lista x se convierte en:

x:  [ a ] -> [ b ] -> [ c ] -> [ d ] -> [ ]
y:  [ c ] -> [ d ] -> [ ]
w:  [ a ] -> [ b ] -> [ c ] -> [ d ] -> [ ]

La lista x ha sido modificada: después de la llamada a append!, x ahora apunta a una lista extendida 
que contiene los elementos de x y y en una única secuencia. Esto se logra modificando el cdr del 
último par de x para que apunte a la lista y.

La lista y no se modifica, pero se comparte con x en cuanto a los elementos. Después de la operación, 
y sigue existiendo como estaba originalmente, pero sus elementos ahora son parte de x al final de su secuencia.

La variable w no es una lista nueva en realidad, ya que simplemente es la referencia a la lista x modificada. 
Por lo tanto, w y x son la misma lista en memoria. |#

(mcdr x) ;-> (b . (c . (d . ())))