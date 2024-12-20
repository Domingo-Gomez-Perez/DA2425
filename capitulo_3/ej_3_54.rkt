#lang racket


(define (cons-stream a b)
  (cons a (delay b)))

(define (stream-car s)
  (car s))

(define (stream-cdr s)
  (force (cdr s)))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

; Stream vacío
(define the-empty-stream '())

; Verificar si el stream es vacío
(define (stream-null? s)
  (null? s))

; Definir el stream de enteros comenzando en 1
(define (integers)
  (cons-stream 1 (stream-map add1 (integers))))

; Definir mul-streams que multiplica dos streams
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

; Definir factorials usando mul-streams
(define factorials
  (cons-stream 1 (mul-streams (integers) factorials)))