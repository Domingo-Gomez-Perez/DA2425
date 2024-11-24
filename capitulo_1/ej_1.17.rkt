#lang racket
#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 1.17: The exponentiation algorithms in this section are based on performing exponentiation by
 means of repeated multiplication. In a similar way, one can perform integer multiplication by means
 of repeated addition. The following multiplication procedure (in which it is assumed that our language
  can only add, not multiply) is analogous to the expt procedure:

(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

This algorithm takes a number of steps that is linear in b. Now suppose we include, together with
 addition, operations double, which doubles an integer, and halve, which divides an (even) integer´
  by 2. Using these, design a multiplication procedure analogous to fast-expt that uses a logarithmic
   number of steps.
|#

; primero veamos fast mult
(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))



; Las dos operaciones que nos piden terer
(define (double x) (* 2 x))
(define (halve x) (/ x 2)) ; solo si es par

; nos piden un procedimiento similar a fast-expt por lo que debera ser recursivo
(define (fast-mul a b)
  (cond ((= b 0)
         0) ; caso basecuando llega a 0
        ((even? b)
         (fast-mul (double a) (halve b))) ; Si es par hacemos lo de multiplcar y dividir
        ((odd? b)
         (+ a (fast-mul a (- b 1)))))); si es impar, lo hacemos par y multiplicamos lo restado

; como vemos, la pila de llamadas va aumentando cuando no es impar y se hace al final.


; pruebas

(fast-mul 100 200)
(* 100 200)

(fast-mul 131 131)
(* 131 131)