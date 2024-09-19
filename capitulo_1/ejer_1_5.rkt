#lang racket
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))
;El programa se queda parado debido a que, antes de evaluar la función test, evalua sus parámetros.
;Al evaluar '(p)', entra en un bucle infinito ya que al ser cuerpo y parámetro iguales, la función p
;nunca se acaba de ejcutar. Si el orden fuese normal, antes de evaluar p se iría al if, el cual haría
;que se devuelva 0 sin necesidad de entrar en p.