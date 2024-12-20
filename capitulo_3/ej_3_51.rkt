#lang racket

(define (stream-enumerate-interval low high)
  (if (> low high)
      empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1)
                                  high))))

(define (stream-map proc s)
    (if (stream-empty? s) 
        empty-stream
        (stream-cons (proc (stream-first s))
                     (stream-map proc (stream-rest s)))))

(define (show x)
  (displayln x)
  x)

(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))


(stream-ref x 5);-> Aparece 5
(stream-ref x 7);-> Aparece 7

;el stream es distinto de una lista puesto que la lista guarda
;espcio en memoria mientras que el stream no. Para llegar al elemento 5
;la complejidad temporal sería 5 y la espacial 1 puesto que solo nos quedamos
;con un valor