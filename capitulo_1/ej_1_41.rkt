#lang racket
;Define a procedure double that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice.
;For example, if inc is a procedure that adds 1 to its argument, then (double inc) should be a procedure that adds 2. What value is returned by

;(((double (double double)) inc) 5)

(define (inc x) (+ x 1))

(define (double f)
  (lambda (x) 
    (f (f x))))

(((double (double double)) inc) 5)
;devuelve 21

;Esto es debido a que double devuelve un procedimiento que se ejecuta 2 veces
;Al existir (double double) se ejecutara 4 veces
;Por ultimo al pasar por otro double sera 8 veces
;Para finalizar inc debe ejecutarse 16 veces haciendo un total de 5+16=21
