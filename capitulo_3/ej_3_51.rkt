#lang racket
; Muestra un numero
(define (show x)
  (displayln x)
  x)

; Crea una lista tipo stream de tamaño stop-start
(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

; Crea un strean-map para referenciar al enumerate interval
(define x 
  (stream-map 
   show 
   (enumerate-interval 0 10)))

; El stream ref lo que hace es referenciar al stream-map creado y te devuelve el numero pedido, esto no consume memoria ya que los numeros que quieres
; Reeferenciar, se crean cuando los llamas.
(stream-ref x 5)
(stream-ref x 7)