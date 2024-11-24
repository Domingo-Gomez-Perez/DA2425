#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.B: Modify the "bob" and "alice" code to use tags. Verify that all of the old code still works.

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(alice-area a)
; 4
(bob-area b)
; 12

; Look at the resulting data structures
a   ; -> '(bob-box (1 . 2) 3 . 4)
b   ; -> '(alice-box (1 . 2) 3 . 4)
|#

; primero ponemos la estructura de las tags
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; la caja de alice
(define (alice-make-box x y w h)
  (attach-tag 'alice-box
              (cons (cons x y) (cons w h))))

; para mirar si es del tipo de alice
(define (alice-box? b) (eq? (type-tag b) 'alice-box))

; la caja de bob
(define (bob-make-box x y w h)
  (attach-tag 'bob-box
              (cons (cons x y) (cons w h))))

; para mirar si es del tipo de bob
(define (bob-box? b) (eq? (type-tag b) 'bob-box))

; metodos para la caja de alice (hay que sacar el tag primero)
(define (alice-width box)
  (abs (- (car (cdr (contents box)))
          (car (car (contents box))))))

(define (alice-height box)
  (abs (- (cdr (cdr (contents box)))
          (cdr (car (contents box))))))

; metodos para la caja de bob (hay que sacar el tag primero)
(define (bob-width box)
  (car (cdr (contents box))))

(define (bob-height box)
  (cdr (cdr (contents box))))

; las areas de cada uno (es lo mismo)
(define (alice-area b)
  (* (alice-width b) (alice-height b)))

(define (bob-area b)
  (* (bob-width b) (bob-height b)))

; PRUEBAS
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

;; Test area calculations
(display (alice-area a))  ; --> 12
(newline)
(display (bob-area b))     ; --> 12
(newline)

;; Display the resulting data structures
(display a)  ; Display Alice's box structure
(newline)
(display b)  ; Display Bob's box structure
(newline)