#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.1: Define a better version of make-rat that handles both
positive and negative arguments. Make-rat should normalize the sign
so that if the rational number is positive, both the numerator and
denominator are positive, and if the rational number is negative,
only the numerator is negative.
|#

(define (make-rat numer denom)
  (if (< denom 0) ; si es menor que 0 el denominador, cambiamos todo de signo
      (make-rat (* numer -1) (* denom -1))
      (let ((g (gcd numer denom)))
        (cons (/ numer g)
              (/ denom g)))))

; pruebas
(make-rat 2 4)    ; => '(1 . 2)
(make-rat -2 4)   ; => '(-1 . 2)
(make-rat 2 -4)   ; => '(-1 . 2)
(make-rat -2 -4)  ; => '(1 . 2)
