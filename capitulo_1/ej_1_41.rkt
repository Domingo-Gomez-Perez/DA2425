#lang racket
#|
**Exercise 1.41:** Define a procedure `double`
that takes a procedure of one argument as argument and returns a procedure that
applies the original procedure twice.  For example, if `inc` is a
procedure that adds 1 to its argument, then `(double inc)` should be a
procedure that adds 2.  What value is returned by

```
(((double (double double)) inc) 5)
```

|#
(define (square n) (* n n))
(define (inc n) (+ n 1))

(define (double double-procedure)
 (lambda (argument) (double-procedure (double-procedure argument)))
  )

;(double-procedure(double-procedure(double-procedure (double-procedure argument))))

(((double (double double)) inc) 5)



#|
El valor retornado por esta función es 21 debido a que si la función double devuelve una función que aplica la función
original (segundo argumento función double) 2 veces, entonces cuando se hace (double double), si el segundo argumento ya se aplicaba 2 veces
al hacer double sobre este, se aplicará 4 veces.

Y finalmente al hacer (double (double double)) se duplicará las veces a 8 que se aplicará la función original, luego al hacer
((double (double double)) inc) se aplicará la función inc 16 veces al valor 5. Entonces, el resultado sera 16 + 5 = 21

|#