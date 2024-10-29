#lang racket


#|

**Exercise 2.26:** Suppose we define `x` and `y` to be two lists:

```
(define x (list 1 2 3))
(define y (list 4 5 6))
```

What result is printed by the interpreter in response to evaluating each of the
following expressions:

```
(append x y)
(cons x y)
(list x y)
```
|#

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ;esta función llamada append añade los elementos de la lista llamada "y" al final de la lista llamada "x":
;'(1 2 3 4 5 6)

(cons x y) ;esta función llamada cons lo que hace es crear una lista de pares con la lista x y la lista y, al ya añadir la lista x,
;no se puede crear otra lista y con el cons porque hay que considerar el null (ya que cons forma
;una lista de pares, pero en este caso, será reemplazado por los elementos de y:
;'((1 2 3) 4 5 6)

(list x y) ;esta función llamada list crea una lista con 2 listas que son las listas x e y (son las listas que se pasasn como argumento):
;'((1 2 3) (4 5 6))

;(define lista1 (list (list 1 2 3) (list 4 5 6)))

;(cdr lista1)
;(display lista1)

