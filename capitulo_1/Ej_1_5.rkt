#lang racket

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))

#|
Lo que ocurrirá si esta función usa el orden aplicativo es que
antes de ejecutarse la función se intenta obtener el valor de los argumentos
y con este ejemplo al evaluar el segundo argumento ((p)) hace que se quede como en
un bucle infinito y no se termina el programa, ni da un valor y no se llega a comparar
el valor de x con 0. Probé usar como argumento p sin los paréntesis y en este caso si me devolvía 0
y no se quedaba en bucle. En conclusión, al llamar a una función y al pasarle un argumento dentro de un paréntesis
, hace que se quede en bucle.

Ej:
(test 0 p)

Por otro lado, si se usa el orden normal, lo que pasaría es que como no intenta obtener los valores
de los argumentos antes de ejecutar esta, sino dentro de la misma si su uso es requerido, es que la
función retornaría un 0 y es lo que se mostraría porque se cumple la condición dentro de la función
y esto evita que se requiera obtener el valor del segundo argumento.

|#