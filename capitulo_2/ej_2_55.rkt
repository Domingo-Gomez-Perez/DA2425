#lang racket
(car ''abracadabra)
; Esto devuelve 'quote porque el simbolo ' es un equivalente a poner '(quote abracadabra) en este caso. Como aqui se pone '' equivale a
; (quote (quote abracadabra)) por lo que el interprete gestiona el primer quote pero al hacer car de (quote abracadabra) devuelve el primer elemento
; que es 'quote.