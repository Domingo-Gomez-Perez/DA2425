#lang racket
;Ejercicio 2.25

(define I (list 1 3 (list 5 7) 9))
(define II (list (list 7)))
(define III (list 1(list 2(list 3(list 4(list 5(list 6 7)))))))

;Lista 1
I
(car(cdr (car (cdr (cdr I)))))
;Lista 2
II
(car(car II))
;Lista 3
III
(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr III))))))))))))
