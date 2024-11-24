#lang racket
;EJERCICIO 1.34

(define (f g) (g 2))

(define (square x) (* x x))

(f square)


(f (lambda (z) (* z (+ z 1))))

(f f)

;Al llamar a (f f), se llama a una funcion g la cual a su vez llama de nuevo
;a la funcion (f 2), provocando asi un bucle infinito