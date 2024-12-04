#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.53: Without running the program, describe the elements of the stream defined by

(define s (stream-cons 1 (add-streams s s)))
|#

; Función para sumar streams
(define (add-streams s1 s2)
  (stream-map + s1 s2))

; Definición del stream s
(define s (stream-cons 1 (add-streams s s)))

; Función para visualizar streams
(define (display-stream s)
  (stream-for-each displayln s))

; Probar la visualización de los primeros 10 elementos del stream
(display-stream (stream-take s 10))
