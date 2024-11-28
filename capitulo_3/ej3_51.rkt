#lang racket
(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (show x)
  (displayln x)
  x)

(define x 
  (stream-map 
   show 
   (enumerate-interval 10 20)))

(stream-ref x 5) ; -> display 15, 15
(stream-ref x 7) ; -> display 17, 17

;; Explicación
;;
;; (stream-ref x 5) y (stream-ref x 7) evalúan elementos del stream x en posiciones específicas.
;;
;; Por claridad, he modificado el intervalo de [0, 10] a [10, 20] para que difieran la posición y el elemento.
;;
;; 1. El stream `x` es un flujo perezoso que comienza en 10 y termina en 20: [10, 11, ..., 20].
;; 2. `stream-map` aplica la función `show` a cada elemento del stream, lo que imprime el valor actual en pantalla (`displayln`) y lo devuelve.
;;
;; Para `(stream-ref x 5)`:
;; - En esta implementación, los elementos previos al índice 5 no se imprimen. Solo el valor en la posición 5 se evalúa.
;; - La función `show` imprime el valor en la posición 5, que es `15`, y luego se devuelve `15`.
;;
;; Para `(stream-ref x 7)`:
;; - El stream ahora evalúa directamente el valor en la posición 7.
;; - La función `show` imprime `17` y se devuelve `17`.
