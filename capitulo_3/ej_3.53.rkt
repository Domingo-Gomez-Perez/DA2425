#lang racket
(require sicp)

; All the auxiliary definitions of subsection 3.5.1

(define (stream-car stream) 
  (car stream))

(define (stream-cdr stream) 
  (force (cdr stream)))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc 
                    (map stream-cdr
                         argstreams))))))


(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin 
        (proc (stream-car s))
        (stream-for-each proc 
                         (stream-cdr s)))))


(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))


(define (add-streams s) (stream-map + s s) )
(define s (cons-stream 1 (add-streams s)))

; Referencia por índice:
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(list (stream-ref s 0) (stream-ref s 1) (stream-ref s 2) (stream-ref s 3) (stream-ref s 4))

#| El primer elemento de s es simplemente 1 debido a stream-cons 1 ....
El segundo elemento de s es la suma de los primeros elementos de s consigo mismo, es decir, 1 + 1 = 2.
El tercer elemento de s es la suma de los segundos elementos de s consigo mismo, es decir, 2 + 2 = 4.
El cuarto elemento de s es la suma de los terceros elementos de s consigo mismo, es decir, 4 + 4 = 8.
El quinto elemento de s es la suma de los cuartos elementos de s consigo mismo, es decir, 8 + 8 = 16.

De esta manera se estan sumando los elementos de s consigo mismo, por lo que se puede ver que el stream s es una lista con las potencias de 2.
|#
