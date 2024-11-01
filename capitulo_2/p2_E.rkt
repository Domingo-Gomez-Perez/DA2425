#lang racket
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Registry
(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name tag)
   (hash-ref registry (list name tag)))

; Bob's box
(define (bob-make-box x y w h)
   (attach-tag 'bob-box
        (cons (cons x y) (cons w h))))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
   (attach-tag 'alice-box
           (cons (cons x1 y1) (cons x2 y2))))

; Bob's namespace
(define (import-bob-box)
  (define (width box)
    (car (cdr (contents box))))
  (define (height box)
    (cdr (cdr (contents box))))
  (define (area box)
    (* (width b) (height b)))
  (register 'width 'bob-box width)
  (register 'height 'bob-box height)
  (register 'area 'bob-box area))

; Alice's namespace
(define (import-alice-box)
  (define (width box)
      (abs (- (car (cdr (contents b)))
          (car (car (contents b))))))
  (define (height box)
      (abs (- (cdr (cdr (contents b)))
          (cdr (car (contents b))))))
  (define (area box)
    (* (width b) (height b)))
  (register 'width 'alice-box width)
  (register 'height 'alice-box height)
  (register 'area 'alice-box area))

; Generic procedure (width)
(define (width box)
    ((lookup 'width (type-tag box)) box))

; Generic procedure (height)
(define (height box)
    ((lookup 'height (type-tag box)) box))

; Generic procedure (area)
(define (area box)
    ((lookup 'area (type-tag box)) box))

; Explicit import
(import-bob-box)
(import-alice-box)

; Comprobar
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)  ; -> 2
(width b)  ; -> 3
(height a) ; -> 2
(height b) ; -> 4
(area a)   ; -> 4
(area b)   ; -> 12

;; Point to ponder: Can the procedures for creating a bob-box and alice-box also be put into a namespace?
;; No, porque el acceso a las funciones específicas se basa en tablas de dispersión (hash).
;; Al definir funciones como width, height y area dentro de cada namespace, forzamos la invocación
;; del procedimiento que las encapsula (import-*-box) para acceder a ellas.
;; Este proceso de "importación" inserta las funciones en el mapa, haciéndolas accesibles para
;; los procedimientos genéricos. Si colocáramos las funciones alice-make-box y bob-make-box
;; dentro de sus respectivos namespaces, no tendríamos una forma directa de invocarlas.

