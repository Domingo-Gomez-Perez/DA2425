#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Special Exercise: As if the last few exercises weren't brain bending enough, it turns out that all of boolean-logic can be encoded solely as procedures. Define this:

(define (TRUE x y) x)
(define (FALSE x y) y)

Now, show how you could use those two functions (and only those functions) to define the common boolean-logic operators:

(define (NOT x) ...)
(define (AND x y) ...)
(define (OR x y) ...)

; Example
(NOT TRUE)         ;-> FALSE
(NOT FALSE)        ;-> TRUE
(AND TRUE TRUE)    ;-> TRUE
(AND TRUE FALSE)   ;-> FALSE
|#

; primero ponemos las que nos dicen
(define (TRUE x y) x)
(define (FALSE x y) y)

; siguiendo la definicion
(define (NOT x)(x FALSE TRUE))
(define (AND x y)(x y FALSE))
(define (OR x y) (x TRUE y))

; va a devolver las cosas como procedimientos no como un valor
(NOT TRUE)         ;-> FALSE
(NOT FALSE)        ;-> TRUE
(AND TRUE TRUE)    ;-> TRUE
(AND TRUE FALSE)   ;-> FALSE
(OR TRUE FALSE)   ;-> TRUE
(OR FALSE FALSE)   ;-> FALSE