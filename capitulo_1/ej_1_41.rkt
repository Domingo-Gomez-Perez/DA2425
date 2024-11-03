
#lang racket


; Hecho por ALVARO GONZALEZ NAVA

#|Define a procedure double that takes a procedure of one argument as
 argument and returns a procedure that applies the original procedure
 twice. For example, if inc is a procedure that adds 1 to its argument
, then (double inc) should be a procedure that adds 2. What value is
returned by (((double (double double)) inc) 5) |#

;Esta función recoge como argumento una funcion  y meidante lambda se realiza
; la funcion hecha dos veces a lo que sea
(define (double f)
  (lambda (x) (f (f x))))

;funcion que suma 1
(define (inc x)
  (+ x 1))


;Lo primero que se hace es (double double) lo que hace que double se devuelva para realizarse dos veces
;Luego se realiza el (double (double double)) lo que hara que se realice 4 veces el double
(((double (double double)) inc) 5)