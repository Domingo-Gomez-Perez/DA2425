#lang racket
;Exercise 3.51: In order to take a closer look at delayed evaluation, we will use the following procedure, which simply returns its argument after printing it:

(define (show x)
  (displayln x)
  x)
;What does the interpreter print in response to evaluating each expression in the following sequence? footnote

(define (stream-enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (stream-enumerate-interval (+ start 1) stop))))

(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))





(stream-ref x 5) ;Devuelve el 5º elemento de la linea dos veces, una por el displayln y otra porque en show se devuelve x, que en este caso seria 5 5
(stream-ref x 7) ;Devuelve el 7º elemento de la lista, que en este caso seria 7 7

;Diferencia entre lista y stream
;Los stream generan los elementos cuando los pide complejidad temporal(n) complejidad espacial 1