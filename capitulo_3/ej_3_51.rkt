#lang racket


#|
**Exercise 3.51:** In order to take a closer look at
delayed evaluation, we will use the following procedure, which simply returns
its argument after printing it:

```
(define (show x)
  (display-line x)
  x)
```


What does the interpreter print in response to evaluating each expression in
the following sequence? [footnote](http://sarabander.github.io/sicp/html/3_002e5.xhtml#FOOT187)

```
(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)
```
|#


(define (show x)
  (displayln x)
  x)

(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))


(define x 
  (stream-map ;Crea un stream de lo siguiente
   show 
   (enumerate-interval 0 10)))

;Con el valor que se pone como argumento se obtiene el numero que está en ese índice teniendo en cuenta el comienzo del intervalo que se ponga
;y lo muestra 2 veces por el display y porque se devuelve el numero resultante. Para (stream-ref x 5) se obtiene 5 que es el valor del número que
;encuentra en la posición 5 de los números 0,1,2,3,4,5; estos números son resultantes del incremento en 1 empezando desde 0.
; Para el (stream-ref x 7) sería 7.

(stream-ref x 5) ; se muestra 7 dos veces
(stream-ref x 7) ; se muestra 9 dos veces



