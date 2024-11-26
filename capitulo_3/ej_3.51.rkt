#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.51: In order to take a closer look at delayed evaluation, we will use the following procedure,
 which simply returns its argument after printing it:

(define (show x)
  (display-line x)
  x)

What does the interpreter print in response to evaluating each expression in the following sequence?

(define x
  (stream-map
   show
   (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)
|#

(define (enumerate-interval start stop)
  (if (> start stop)
      empty-stream
      (stream-cons start (enumerate-interval (+ start 1) stop))))

(define (show x)
  (displayln x)
  x)

(define x (stream-map show (enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)

#|
Cuando se ejecuta (stream-ref x 5), se imprime un 5, y al ejecutar (stream-ref x 7), se imprime un 7. La función x define
un stream-map que aplica la función show a todos los elementos del stream generado por enumerate-interval. Esta última
función genera una lista de números del 0 al 10. Al llamar a (stream-ref x 5), se accede al stream x, que contiene la lista
de 0 a 10, y se aplica la función show al quinto elemento, imprimiendo y devolviendo el número 5. De manera similar, al llamar
a (stream-ref x 7), se aplica la función show al séptimo elemento, imprimiendo y devolviendo el número 7. Como x es un stream,
los elementos no se evalúan todos de una vez, sino que stream-ref evalúa solo el elemento en el índice especificado, aplicando la
función show en ese momento.
|#
