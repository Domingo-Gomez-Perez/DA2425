#lang racket


#|
**Exercise 1.4:** Observe that our model of evaluation allows for
combinations whose operators are compound expressions.  Use this
observation to describe the behavior of the following procedure:

```
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```
|#

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

#|

Explicación:
Se define una función llamada "a-plus-abs-b" que tiene 2 argumentos que
son a y b; que lo que hace es comparar el valor de b con 0, y si b es
mayor que 0, se suman los valores de a y b (a + b);y en caso contrario,
se realiza la operación a - b.
|#