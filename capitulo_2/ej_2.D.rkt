#lang racket

#|
Hecho por
EZQUERRA CEBERRA, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.D: A registry to your code. Register various width/height procedures with the registry. Write generic width/height/area procedures.

|#

; vamos parte por parte

; lo de las tags
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

; ahora lo del hash
(define registry (make-hash))

(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

(define (lookup name tag)
  (hash-ref registry (list name tag)))

; ahora registramos todo
(register 'width 'bob-box bob-width)
(register 'width 'alice-box alice-width)
(register 'height 'bob-box bob-height)
(register 'height 'alice-box alice-height)
(register 'area 'bob-box bob-area)
(register 'area 'alice-box alice-area)

; ahora creamos los genericos
(define (width box)
  ((lookup 'width (type-tag box)) box))

(define (height box)
  ((lookup 'height (type-tag box)) box))

(define (area box)
  ((lookup 'area (type-tag box)) box))

; ahora vamos a probar si funciona
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(display (width a))   ; ->  2 (ancho de la caja de Alice)
(newline)
(display (height a))  ; ->  2 (altura de la caja de Alice)
(newline)
(display (area a))    ; ->  4 (área de la caja de Alice)
(newline)

(display (width b))   ; ->  3 (ancho de la caja de Bob)
(newline)
(display (height b))  ; -> 4 (altura de la caja de Bob)
(newline)
(display (area b))    ; ->  12 (área de la caja de Bob)
(newline)

;; Vamos a ver la estructura para ver que no ha cambiado

(display a)
(newline)
(display b)
(newline)