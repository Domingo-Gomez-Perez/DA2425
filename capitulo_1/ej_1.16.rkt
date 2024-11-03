#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.16: Design an iterative version of the fast-expt procedure given in the text.
Hint: to do this, it might help to use a subtle trick of algorithm design.
Normally, when implementing an algorithm, you're thinking about how to break a problem
down into smaller and smaller steps (e.g., subdividing the problem into parts).
However, sometimes it might make sense to change the problem into a different,
but equivalent problem. For example, suppose you were computing 2^16.
You could rewrite this problem by doubling the base and halving the exponent.
Thus, it's really the same as computing 4^8. Perhaps this trick could be used in
your solution.
|#

; el fast exp tal cual:
(define (fast-expt b n)
  (cond ((= n 0)
         1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else
         (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x) (* x x))

; si nos fijamos en la pila de llamadas que hace, vamos guardando *b y agadndando
; la pila por lo que se trata de un proceso recursivo

; ahora vamos a hacer la version iterativa.
; lo primero, va a llevar encapsulamiento. Lo ponemos todo dentro del mismo define para
; hacer black box abstraction
; Iterative version of fast-expt
(define (fast-expt-iter b n)
  (define (fast-expt-iter-capsula base exp result)
    (cond ((= exp 0) result)  ; caso base, hemos llegado a exp 0
          ((even? exp) (fast-expt-iter-capsula (* base base) (/ exp 2) result)) ; si es par, hacemos lo del algoritmo
          (else (fast-expt-iter-capsula base (- exp 1) (* base result))))) ; si no es par, lo hacemos par
  (fast-expt-iter-capsula b n 1)) ; esto empieza a llamar al encapsulado. Ponemos el resultado como 1

; si nos fijamos en la pila de este, vemos que cada vez que acaba una llamada, se elimina
; y continua con la siguiente sin nececsidad de volver a verla. Por ello se trata d 
; un proceso iterativo

; pruebas
(fast-expt 2 0)
(fast-expt 2 4)
(fast-expt 2 8)
(fast-expt 3 3)

(fast-expt-iter 2 0)
(fast-expt-iter 2 4)
(fast-expt-iter 2 8)
(fast-expt-iter 3 3)