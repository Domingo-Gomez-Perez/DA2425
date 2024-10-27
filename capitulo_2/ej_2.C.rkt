#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.C: Write generic procedures for width, height, and area. Verify correct behavior.

|#

; ahora hay que hacer procedimientos genericos teniendo lo del 2b

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

; hata aqui lo que teniamos de antes --------

; ahora hacerlo generico
; tambien se podria pasar contents de b a los metodos para evitar haber tenido que
; cambiarlos antes pero como nos piden hacerlo sobre lo del 2b, no lo tocamos

(define (width b)
  (cond ((bob-box? b) (bob-width b))
        ((alice-box? b) (alice-width b))
        (else (error "Unknown box type"))))

(define (height b)
  (cond ((bob-box? b) (bob-height b))
        ((alice-box? b) (alice-height b))
        (else (error "Unknown box type"))))

(define (area b)
  (cond ((bob-box? b) (bob-area b))
        ((alice-box? b) (alice-area b))
        (else (error "Unknown box type"))))

; PRUEBAS

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)
(width b)
(newline)

(height a)
(height b)
(newline)

(area a)
(area b)