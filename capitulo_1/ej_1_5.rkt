#lang racket
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))
;Then he evaluates the expression

(test 0 (p))

;What behavior will Ben observe with an interpreter that uses applicative-order evaluation?
;What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer.

;Con un interprete aplicativo al ejecutar (test 0 (p)) primero se evaluan los argumentos a pasar,
;Se evalua 0 y al ser un simple número se pasa a (p). Al intentar evaluar (p) esto lleva a una recursion y por tanto un bucle infinito
;Por tanto no llegara nunca a entrar al cuerpo de la funcion test

;Con un interprete normal al ejecutar (test 0 (p)) los argumentos solo se evaluaran cuando sea necesario, por ello entra al cuerpo de la funcion.
;Una vez dentro lee el valor de x (0) para compararlo en el if, y al ser igual a 0 devolvera "0", sin ser necesario evaluar "y" al no llegar nunca a ello.