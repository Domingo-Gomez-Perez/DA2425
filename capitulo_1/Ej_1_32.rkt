#lang racket
; Ejercicio 1.32

; Parte 1

(define (accumulate combiner null-value term a next b) (
    if (> a b)
       null-value
       (combiner (term a) (accumulate combiner null-value term (next a) next b) )
                                                        ))

(define (suma a b) (+ a b))
(define (identity x) x)
(define (next x) (+ x 1))
(define (mult x y) (* x y))

(define (sum a b) (
    accumulate suma 0 identity a next b
                   ))

(define (product a b) (
    accumulate mult 1 identity a next b
                       ))

; Parte 2

(define (accumulate-iter combiner null-value term a next b) (
    if (> a b)
       null-value
       (accumulate combiner (term a) term (next a) next b)
                                                        ))

(define (sum-iter a b) (
    accumulate-iter suma 0 identity a next b
                   ))
