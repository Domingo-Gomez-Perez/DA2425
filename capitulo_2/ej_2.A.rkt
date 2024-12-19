#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.A: Enter the above code for Bob's and Alice's box. Verify that it works and look at the resulting data structures:

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(alice-area a)
; 4
(bob-area b)
; 12

; Look at the resulting data structures
a        ; -> '((1 . 2) 3 . 4)
b        ; -> '((1 . 2) 3 . 4)
|#

; Bob's box
(define (bob-make-box x y w h)
  (cons (cons x y) (cons w h)))

(define (bob-width box)
   (car (cdr box)))

(define (bob-height box)
   (cdr (cdr box)))

(define (bob-area box)
    (* (bob-width box) (bob-height box)))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (cons (cons x1 y1) (cons x2 y2)))

(define (alice-width box)
   (abs (- (car (cdr box))
           (car (car box)))))

(define (alice-height box)
   (abs (- (cdr (cdr box))
           (cdr (car box)))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))


(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(alice-area a)
; 4
(bob-area b)
; 12

; Look at the resulting data structures
a        ;-> '((1 . 2) 3 . 4)
b        ;-> '((1 . 2) 3 . 4)

; vemos que efectivamente tienen la misma esctructura pero cada uno lo representa a su manera.