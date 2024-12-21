#lang racket
; Ejercicio 3.52

; Funciones anteriores

(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (display-stream s)
  (stream-for-each displayln s))

; Funciones del ejercicio

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
; sum = Elemento número 7 de la lista que forman los números pares de la lista que forman los valores del sumatorio entre 1 y 20
(display-stream z)
; sum = Lista de los elementos multiplos de 5 de la lista que forman los elementos de un sumatorio de 1 a 20
; Cabe destacar que el valor se sum no cambia en ningún momento. Cuando se crea un stream se copia al
; ambiente del stream los valores de las variables y se crean otras con el mismo nombre. Esto significa
; que cuando accum cambia el valor de sum, está cambiando el valor de la copia de sum que el stream
; tiene en su ambiente.