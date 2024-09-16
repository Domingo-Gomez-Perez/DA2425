#lang racket
(define (a-plus-abs-b a b) ; Define una funcion con dos variables
  ((if (> b 0) + -) a b)) ; Es una condicion para saber si la segunda variable "b" es positiva o negativa, en caso de ser positva, se suma a la primera variable
                          ; en caso contrario, al ser negativa la variable, se resta para que de esta manera pase a sumar, es decir a - (-b) = a + b

; Es decir, la funcion sirve para hacer una suma en valor absoluto