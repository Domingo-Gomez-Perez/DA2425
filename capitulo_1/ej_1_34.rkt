#lang racket

#|
**Exercise 1.34:** Suppose we define the procedure

```
(define (f g) (g 2))
```

Then we have

```
(f square)
4

(f (lambda (z) (* z (+ z 1))))
6
```

What happens if we (perversely) ask the interpreter to evaluate the combination
`(f f)`?  Explain.
|#

(define (inc n) (+ n 1))
(define (square a) (* a a))
(define (f g) (g 2))
(f square) 

(f (lambda (z) (* z (+ z 1))))

;el segundo argumento de la funcion f es una función lambda que tiene una argumento que vale 2 y que este se suma a 1
;y luego se multiplica por 2 (valor del argumento de la funcion lambda) y esto da 6 que es lo que muestra la función f

#|
(define (z g)
  (g g)
  (g 1))
|#

#|
(f f)

Al evaluar esto, da un error debido a que al evaluarlo en orden aplicativo se espera
que el argumento de la función f (la segunda "f") se trate de un procedimiento que realice
alguna operación sobre el número que está en esta función (f).
|#
