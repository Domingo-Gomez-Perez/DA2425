Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

Se define una funcion con 2 argumentos en los que en caso de que b sea mayor que 0 se suma en caso contrario se resta.
