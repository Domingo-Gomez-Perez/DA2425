#lang racket
(require racket/stream)

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define (stream-enumerate-interval low high)
  (if (> low high)
      '()
      (stream-cons 
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define (display-stream stream)
  (stream->list stream))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
;Primero se va a seq y su stream-enumerate-interval, que devuelve (1, 3, 6, 10, ..., 210). Luego se va a y y se filtran los elementos pares quedándonos con
;(6, 10, 28, ..., 210). Finalmente se obtiene el octavo elemento (ínidice 7 contando 0 como número) de la lista, que es 136.
(display-stream z)
;Primero se va a seq y su stream-enumerate-interval, que devuelve (1, 3, 6, 10, ..., 210). Luego se va a stream-filter y se devuelven solo los elementos
;múltiplos de 5: (10 15 45 55 105 120 190 210). FInalmente se imprime esa misma lista.

;El valor de sum será 210


