#lang racket

;Hecho por 
; EZQUERRA CEBALLOS, CARLOS
; FERNÁNDEZ RIVERA, CRISTIAN MANUEL
; GOMEZ GARCIA, GABRIEL
; MUÑOZ FERNANDEZ, PAULA

#|
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

; Iterative version of fast-expt
(define (fast-expt base exp)
  (define (iter base exp result)
    (cond
      [(= exp 0) result]               ; If exponent is 0, return the result (base^0 = 1)
      [(even? exp)                      ; If exponent is even
       (iter (* base base) (/ exp 2) result)] ; Square the base and halve the exponent
      [else                            ; If exponent is odd
       (iter base (- exp 1) (* base result))])) ; Multiply result by base and decrement the exponent
  (iter base exp 1))                     ; Initialize result as 1
