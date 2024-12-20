#lang racket

#|

**Exercise 3.12:**  The following procedure for
appending lists was introduced in 2.2.1.  It has been modified for use in Racket specifically
for this exercise.

```
(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))
```

`Append` forms a new list by successively `cons`ing the elements of
`x` onto `y`.  The procedure `append!` is similar to
`append`, but it is a mutator rather than a constructor.  It appends the
lists by splicing them together, modifying the final pair of `x` so that
its `cdr` is now `y`.  (It is an error to call `append!` with an
empty `x`.)

```
(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)
```

Here `last-pair` is a procedure that returns the last pair in its
argument:

```
(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))
```

Consider the interaction

```
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
```

What are the missing `⟨response⟩`s?  Draw box-and-pointer diagrams to
explain your answer.
|#

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


;Primera interaccion
(display "Primera interaccion")
(displayln "")
(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))
(define z (append x y))
z ;(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))
(mcdr x)

#|
Respuesta:

Al definir  x e y los diagramas quedarían así:

x:  [a] --> [b] --> null
y:  [c] --> [d] --> null

Despues creo una nueva lista z copiando los elementos de x y añadiendo los de y.
No se modifica ni x ni y tras este procedimiento, quedando z representado de la siguiente forma
en el diagrama:

z:  [a] --> [b] --> [c] --> [d] --> null

Tras hacer (mcdr x) se muestra (mcons 'b '()) que es el primer "response" y que en el diagrama es (tras hacer el (mcdr x) no se modifica x):

[b] --> null

Esto sucede debido a que la función append no modifica x.

|#


;Segunda interacción
(displayln"")
(display "Segunda interaccion")
(displayln"")
(define w (append! x y))
w ;(mcons 'a (mcons 'b (mcons 'c (mcons 'd '()))))

(mcdr x)


#|
Respuesta:

A diferencia de lo anterior a usar la función append! para definir a w , se modifica de manera destructiva el último par
de x para que su cdr apunte a y. Entonces, x y w comparten la misma estructura y el diagrama es el siguiente para ambos:

x, w: [a] --> [b] --> [c] --> [d] --> null


Tras hacer (mcdr x) se muestra (mcons 'b (mcons 'c (mcons 'd '()))), este es el segundo "response", y esto es
 debido a que append! modificó x y que en el diagrama para lo que se muestra es (tras hacer el (mcdr x) no se modifican ni x ni w):

[b] --> [c] --> [d] --> null



|#