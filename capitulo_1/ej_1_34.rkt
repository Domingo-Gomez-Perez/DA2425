#lang racket

; Exercise 1.34

; Suppose we define the procedure

(define (f g) 
 (g 2))


; Then we have

; (f square) -> 4
(f (lambda (x) (* x x))) 

; (f (lambda (z) (* z (+ z 1)))) -> 6
(f (lambda (z) (* z (+ z 1)))) 


; What happens if we (perversely) ask the interpreter to 
; evaluate the combination (f f)? Explain.


; I will use substitution to check what is happening:

; (f f)
; (f 2)
; (2 2)

; We can see that evaluating (f f) is the same as evaluating (2 2).
; Indeed, if we evaluate both, the error is the same