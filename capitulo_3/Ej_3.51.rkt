#lang racket
(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))
;Ej 3.51
(define (show x)
  (displayln x); Muestra en consola el stream
  x); Esta x hace que aperezca dos veces

(define x 
  (stream-map ; Crea un stream de lo siguiente
   show 
   (enumerate-interval 0 10))) ; Hace de argumento para el show y acota el argumento a un intervalo 

(stream-ref x 5); Ejecuta la funcion x y muestra el valor con el indice 5 en el enumerado, Aparece dos veces ya que hay un displayln y además lo devuelve el show
(stream-ref x 7)