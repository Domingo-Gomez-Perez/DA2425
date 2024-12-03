#lang racket

; Definimos los "Church numerals"
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f( f x)))))

; Metodo para sumar "Church numerals"
(define (church-suma num1 num2)
  (lambda (f) (lambda (x) ((num1 f) ((num2 f) x)))))

; Aqui podemos definir three como la suma de one y two
(define three (church-suma one two))

; Metodo para multiplicar "Church numerals"
(define (church-mult num1 num2)
  (lambda (f) (num1 (num2 f))))

; Metodo para pasar de "Church numerals" a int 
(define (church-to-int num)
  ((num (lambda (x) (+ x 1))) 0))


; Ejemplos

(define six (church-mult two three)) ; Define el "Church numerals" six = 6

(church-to-int (church-suma one two)) ; Saca por pantalla la suma de one y two (3)

(define nine (church-mult three three)) ; Define nine, es decir, la multiplicacion de three y three

(church-to-int nine) ; Saca por pantalla nine (9)
