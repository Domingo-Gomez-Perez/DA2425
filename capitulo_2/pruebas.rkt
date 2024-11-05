#lang racket
; para poner un tag y para ver el contenido y el tipo
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; ejemplo
(define dato (attach-tag 'int 23))    ; -> (int 23)
(type-tag dato)                       ; -> 'int
(contents dato)                       ; -> 23
