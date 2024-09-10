#lang racket

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

#|
Se define una función llamada "a-plus-abs-b" que tiene 2 argumentos que
son a y b; que lo que hace es comparar el valor de b con 0, y si b es
mayor que 0, se suman los valores de a y b (a + b);y en caso contrario,
se realiza la operación a - b.
|#