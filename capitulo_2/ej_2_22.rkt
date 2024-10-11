#lang racket


#|
**Exercise 2.22**: Louis Reasoner tries to rewrite
the first `square-list` procedure of Exercise 2.21 so that it
evolves an iterative process:

```
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))
```

Unfortunately, defining `square-list` this way produces the answer list in
the reverse order of the one desired.  Why?


Louis then tries to fix his bug by interchanging the arguments to `cons`:

```
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items nil))
```

This doesn't work either.  Explain.
|#

(define (square x)
  (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(define lista1 (list 2 3 5 6))
(display "square-list 1")
(square-list lista1)

#|
Unfortunately, defining `square-list` this way produces the answer list in
the reverse order of the one desired.  Why?
Respuesta: Esto se debe a que el primer elemento que se eleva al cuadrado de la lista se va colocando en la posición inicial, entonces
lo que pasa es que el último elemento de la lista que se itera antes de que la lista quede vacía se coloca al inicio

Una posible solución, sería invertir la lista resultante justo antes de retornar, es decir cuando se cumple que la lista está vacía y la
lista resultante con los cuadrados de los elementos de la anterior lista


|#

(define (square2-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items null))

(newline)
(display "square-list 2")
(square2-list lista1)

#|
This doesn't work either.  Explain.
Respuesta: Esto tampoco es correcto debido a que se forma una lista con otra lista y el elemento al cuadrado de la otra lista a
medida que se va iterando
|#

