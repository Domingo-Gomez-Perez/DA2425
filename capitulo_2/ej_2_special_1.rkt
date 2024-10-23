#lang racket

; Special Exercise

; As if the last few exercises weren't brain bending enough, it turns out that all of boolean-logic 
; can be encoded solely as procedures. Define this:

(define (TRUE x y) x)
(define (FALSE x y) y)

; Now, show how you could use those two functions (and only those functions) to define the common 
; boolean-logic operators:


; If (False) : True,  Else : False
(define (NOT f)
  (f FALSE TRUE))

; If (True True) : True,  Else : False
(define (AND x y)
  (x y FALSE))

; If (False False) : False,  Else : True
(define (OR x y)
  (x TRUE y))


; Tests:
(NOT TRUE)         ;-> FALSE
(NOT FALSE)        ;-> TRUE

(AND TRUE TRUE)    ;-> TRUE
(AND TRUE FALSE)   ;-> FALSE
(AND FALSE TRUE)   ;-> FALSE
(AND FALSE FALSE)  ;-> FALSE

(OR TRUE TRUE)    ;-> TRUE
(OR TRUE FALSE)   ;-> TRUE
(OR FALSE TRUE)   ;-> TRUE
(OR FALSE FALSE)  ;-> FALSE