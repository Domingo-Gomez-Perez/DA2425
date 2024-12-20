#lang racket


;-----------------------------------------------------
;Para definir el tag
(define (attach-tag tag contents) (cons tag contents))
;El tipo que es
(define (type-tag datum) (car datum))
;El valor que tiene
(define (contents datum) (cdr datum))

;Esto es para crear un tabla hash
(define registry (make-hash))

;registra en la tabla un proceso
(define (register name tag proc)
   (hash-set! registry (list name tag) proc))
;Busca en el registro lo que hay
(define (lookup name object)
   (hash-ref registry (list name object)))
;-----------------------------------------------------

;-----------------------------------------------------

(define (width box)
  ((lookup 'width (type-tag box)) box))

(define (height box)
  ((lookup 'height (type-tag box)) box))

(define (area box)
  ((lookup 'area (type-tag box)) box))
;-----------------------------------------------------

;-----------------------------------------------------
;|                   Ejercicio 2.E                   |
;-----------------------------------------------------
(define (import-bob-box)
  (define (bob-make-box x y w h)
    (attach-tag 'bob-box (cons (cons x y) (cons w h))))
  (define (bob-width box)
     (car (cdr (contents box))))
  (define (bob-height box)
    (cdr (cdr (contents box))))
  (define (bob-area box)
    (* (bob-width box) (bob-height box)))
  (register 'width 'bob-box bob-width)
  (register 'height 'bob-box bob-height)
  (register 'area 'bob-box bob-area)
  bob-make-box
)

(define (import-alice-box)
   (define (alice-make-box x y w h)
       (attach-tag 'alice-box (cons (cons x y) (cons w h))))
   (define (width box)
       (abs (- (car (cdr (contents box)))
          (car (car (contents box))))))
   (define (height box)
       (abs (- (cdr (cdr (contents box)))
          (cdr (car (contents box))))))
   (define (alice-area box)
       (* (width box) (height box)))
   (register 'width 'alice-box width)
   (register 'height 'alice-box height)
   (register 'area 'alice-box alice-area)
   alice-make-box
)

; Explicit import (in code that wants to use it)
(define alice-make-box (import-alice-box))
(define bob-make-box (import-bob-box))

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)  ; -> 2
(width b)  ; -> 3
(height a) ; -> 2
(height b) ; -> 4
(area a)   ; -> 4
(area b)   ; -> 12