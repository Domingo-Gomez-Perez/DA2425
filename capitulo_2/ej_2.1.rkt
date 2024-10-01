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

(define (make-rat n d)
  (if (< d 0) 
      (make-rat (* n -1) (* d -1)) 
      (let ((g (gcd n d)))
        (cons (/ n g) 
              (/ d g)))))

; pruebas
(make-rat 2 4)    ; => '(1 . 2)
(make-rat -2 4)   ; => '(-1 . 2)
(make-rat 2 -4)   ; => '(-1 . 2)
(make-rat -2 -4)  ; => '(1 . 2)
