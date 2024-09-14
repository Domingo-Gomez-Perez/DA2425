#lang racket


#|
**Exercise 1.3:** Define a procedure that takes three numbers as
arguments and returns the sum of the squares of the two larger
numbers.
|#

(define (square a b c)
  (cond ((or(and (> a b) (> c b))  (and (= a b) (> c a)) (= a b c))  (+(* a a) (* c c)))
        ((or(and (> b a) (> c a)) (and (= a c) (> b a)) (= a b c)) (+(* b b) (* c c)))
        ((or(and (> a c) (> b c)) (and (= b c) (> a b)) (= a b c)) (+(* a a) (* b b))))
  )
 
#|
Esta función llamada square que se requiere en el ejercicio toma como
argumento 3 números y para que se cumpla con la función pedida (devolver
la suma de los cuadrados de los dos números más grandes); se realizan 3
comparaciones:
 -En la primera se comprueba si a es mayor que b y c es mayor que b; o si a es igual que
 b y c es mayor que a; o si los tres valores son iguales.
 -En la segunda se verifica si b es mayor que a y c es mayor que a; o si a es igual que c
 y b es mayor que a; o si los tres valores son iguales.
 -En la tercera se comprueba si a es mayor que c y b es mayor que c; o si b es igual que c
 y a es mayor que b; o si los tres valores son iguales.


Entonces, al cumplirse alguna de las condiciones, se realizará la operación requerida, pero hay
que mencionar que si los tres valores son iguales se hace la suma de los cuadrados de 2 de ellos,
y para el caso de las condiciones de que hayan 2 iguales; he tenido en cuenta las poibles operaciones
resultantes.

|#   
