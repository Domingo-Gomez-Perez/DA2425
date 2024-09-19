#lang racket

(define (f x) 
   (let ((a (+ x 10))
         (b (* a 5)))
         (+ a b))
)
(f 2)      ; Fails.  Why?

;Equivalente a:
(define x 2)
((lambda (a b) (+ a b)) (+ x 10) (* a 5))

;Aquí también se da el fallo ya que el valor de b se le da desde fuera del 'environment' en el que
;están definidos a y b. Por lo tanto, intentar sustituirlos en la asignación de valor da un " a:
;unbound identifier in: a".