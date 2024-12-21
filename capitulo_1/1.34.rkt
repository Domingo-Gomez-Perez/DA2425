#lang racket
(define (f g) (g 2))


(f (lambda (z) (* z (+ z 1))))
(f f) ; Provoca un error ya que la segunda f toma el valor de g, la cual cuando va a ser sustituida pasa a ser la expresion a (f 2), lo cual es invalido ya que el segundo termino tiene que ser una función