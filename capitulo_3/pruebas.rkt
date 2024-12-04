#lang racket

; Definición de cons-stream
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b) (cons a (delay b)))))

; Funciones para acceder a un stream
(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

; stream-map: Aplica una función a cada elemento de uno o más streams
(define (stream-map proc . streams)
  (if (null? (car streams))
      '()
      (cons-stream
       (apply proc (map stream-car streams))
       (apply stream-map (cons proc (map stream-cdr streams))))))

; add-streams: Suma elemento a elemento dos streams
(define (add-streams s1 s2)
  (stream-map + s1 s2))

; Stream infinito de unos
(define ones (cons-stream 1 ones))

; Stream de enteros infinitos
(define integers
  (cons-stream 1 (add-streams ones integers)))

; Obtener los primeros 10 elementos del stream de enteros
(define (take n stream)
  (if (= n 0)
      '()
      (cons (stream-car stream) (take (- n 1) (stream-cdr stream)))))

(take 10 integers)
