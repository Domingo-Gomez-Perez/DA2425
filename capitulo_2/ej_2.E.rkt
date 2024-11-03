#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.E: Put the generic "bob" and "alice" functions into their own namespace as shown. Point to ponder: Can the procedures for creating a bob-box and alice-box also be put into a namespace?

|#

; hay que encapsular todo lo de alice y bob pero la parte del registro tenemos que dejarla fuera
; ya que los dos usan el mismo registro y necesitan sus metodos.

; Lo de los tags
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; lo de los registros
(define registry (make-hash))

(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

(define (lookup name tag)
  (hash-ref registry (list name tag)))

; estos dos por fuera porque se necesitan dentro de las dos

; Ahora los namespaces para alice y bob. (poner todo dentro del define)

(define (import-alice-box)
  (define (alice-make-box x y w h)
    (attach-tag 'alice-box (cons (cons x y) (cons w h))))

  (define (alice-width box)
    (abs (- (car (cdr (contents box)))
            (car (car (contents box))))))

  (define (alice-height box)
    (abs (- (cdr (cdr (contents box)))
            (cdr (car (contents box))))))

  (define (alice-area box)
    (* (alice-width box) (alice-height box)))

  ; Lo registramos
  (register 'width 'alice-box alice-width)
  (register 'height 'alice-box alice-height)
  (register 'area 'alice-box alice-area)

  )

(define (import-bob-box)
  (define (bob-make-box x y w h)
    (attach-tag 'bob-box (cons (cons x y) (cons w h))))

  (define (bob-width box)
    (car (cdr (contents box))))

  (define (bob-height box)
    (cdr (cdr (contents box))))

  (define (bob-area box)
    (* (bob-width box) (bob-height box)))

  ; Lo registramos
  (register 'width 'bob-box bob-width)
  (register 'height 'bob-box bob-height)
  (register 'area 'bob-box bob-area)

  )

; ahora creamos los genericos
(define (width box)
  ((lookup 'width (type-tag box)) box))

(define (height box)
  ((lookup 'height (type-tag box)) box))

(define (area box)
  ((lookup 'area (type-tag box)) box))

; Import boxes
(define make-bob-box (import-bob-box))
(define make-alice-box (import-alice-box))

(import-bob-box)
(import-alice-box)
; Now we can create boxes using the constructors
(define a (make-alice-box 1 2 3 4))
(define b (make-bob-box 1 2 3 4))

; Test the width, height, and area functions
(display (width a))   ; -> 2
(newline)
(display (height a))  ; -> 2
(newline)
(display (area a))    ; -> 4
(newline)

(display (width b))   ; -> 3
(newline)
(display (height b))  ; -> 4
(newline)
(display (area b))    ; -> 12
(newline)
; Display box structures
(display a)
(newline)
(display b)
(newline)
