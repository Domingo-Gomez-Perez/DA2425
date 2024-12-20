#lang racket

;-----------------------------------------------------
;Para definir el tag
(define (attach-tag tag contents) (cons tag contents))
;El tipo que es
(define (type-tag datum) (car datum))
;El valor que tiene
(define (contents datum) (cdr datum))
;-----------------------------------------------------

;METODOS DE BOB
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

; type-check procedure
(define (bob-box? b) (eq? (type-tag b) 'bob-box))

; Other methods (note: must extract the contents from the tagged value)
(define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) (cdr (cdr (contents b))))
(define (bob-area b)  (* (bob-width b) (bob-height b)))

;------------------------------------------------------

;METODOS DE ALICE
(define (alice-make-box x y w h)
    (attach-tag 'alice-box
         (cons (cons x y) (cons w h))))

; type-check procedure
(define (alice-box? b) (eq? (type-tag b) 'alice-box))

; Other methods (note: must extract the contents from the tagged value)
(define (alice-width b)
  (abs (- (car (cdr (contents b)))
          (car (car (contents b))))))
(define (alice-height b)
  (abs (- (cdr (cdr (contents b)))
          (cdr (car (contents b))))))
(define (alice-area b)  (* (alice-width b) (alice-height b)))

;------------------------------------------------------
;Ejemplos basicos
;(make-hash)              ; Create a mutable hash table
;(hash-set! h key val)    ; Add an entry
;(hash-ref h key)         ; Look up a value

; Example
(define h (make-hash))
(hash-set! h 'foo 42)
(hash-set! h 'bar 37)
(hash-ref h 'foo)        ; -> 42
(hash-ref h 'bar)        ; -> 37

;-------------------------------------------------------


;Esto es para crear un tabla hash
(define registry (make-hash))

;registra en la tabla un proceso
(define (register name tag proc)
   (hash-set! registry (list name tag) proc))
;Busca en el registro lo que hay
(define (lookup name object)
   (hash-ref registry (list name object)))

;-----------------------------------------------------
;|                   Ejercicio 2.D                   |
;-----------------------------------------------------

;Width
(register 'width 'bob-box bob-width)
(register 'width 'alice-box alice-width)

; Generic procedure
(define (width box)
    ((lookup 'width (type-tag box)) box))

;-----------------------------------------

;Height
(register 'height 'bob-box bob-height)
(register 'height 'alice-box alice-height)

; Generic procedure
(define (height box)
    ((lookup 'height (type-tag box)) box))


(register 'area 'bob-box bob-area)
(register 'area 'alice-box alice-area)

; Generic procedure
(define (area box)
    ((lookup 'area (type-tag box)) box))


(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

;Width
(width a)
(width b)

;Altura
(height a)
(height b)

;Area
(area a)
(area b)
