#lang racket
(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (+ x 1))

(((double (double double)) inc) 5)

;Deberia retornar 21 ya que (double double) aplica el doble del doble es decir 4 veces
;y si a eso le aplicamos un doble, significa que aplicamos el incremento 16 veces, por lo que
;el resultado es 16+5=21