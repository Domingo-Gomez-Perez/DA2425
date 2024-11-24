#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Reading Section 1.1.8. Rewrite the sqrt procedure to use internal procedures as described.
|#

#|
estos dos son cosas mas generales y auxiliares al probema asi que podrian ir fuera
pero como queremos todo dentro, todo dentro.

  ; la media
  (define (average a b)
    (/ (+ a b) 2))

  ; el cuadrado
  (define (square a) (* a a))
|#

; la sqrt con lexical scooping
(define (sqrt x)
  ; la media
  (define (average a b)
    (/ (+ a b) 2))

  ; el cuadrado
  (define (square a) (* a a))

  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))

  (define (improve guess)
    (average guess (/ x guess)))

  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))


; ejemplos
(sqrt 9)
; 3.00009155413138

(sqrt (+ 121 49))
; 13.038404884948097