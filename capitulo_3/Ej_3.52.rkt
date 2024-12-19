#lang racket


(define (enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (enumerate-interval (+ start 1) stop))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

;Ej 3.52
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

(stream-ref y 1)
;sum no se modifica por lo que es 0, ya que accum se hace en el ambiente del stream
(display-stream z)
;sum no se modifica ya que se modifica el accum invocado esta dentro del ambiente del stream
;No se modifican,el cambio del delay ya que el accum se sigue modificando en oreo ambiente


