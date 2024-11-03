#lang racket

#|
Exercise 2.E: Put the generic "bob" and "alice" functions into their own namespace as shown.
 Point to ponder: Can the procedures for creating a bob-box and alice-box also be put into a namespace?
|#


(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name object)
 (hash-ref registry (list name object)))



; Generic procedure
(define (width box)
    ((lookup 'width (type-tag box)) box))


(define (height box)
    ((lookup 'height (type-tag box)) box))

(define (area box)
    ((lookup 'area (type-tag box)) box))



(define (import-bob-box)
  (define (bob-make-box x y w h)
  (attach-tag 'bob-box (cons (cons x y) (cons w h))))
   (define (width box)
    ((lookup 'width (type-tag box)) box))
   (define (height box)
    ((lookup 'height (type-tag box)) box))
  (define (area box)
    ((lookup 'area (type-tag box)) box))
   (register 'width 'bob-box width)
   (register 'height 'bob-box height)
  (register 'area 'bob-box area)
)

(define (import-alice-box)
  (define (alice-make-box x1 y1 x2 y2)
 (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))
   (define (width box)
    ((lookup 'width (type-tag box)) box))
   (define (height box)
    ((lookup 'height (type-tag box)) box))
  (define (area box)
    ((lookup 'area (type-tag box)) box))
   (register 'width 'alice-box width)
   (register 'height 'alice-box height)
  (register 'area 'alice-box area)
)

; Explicit import (in code that wants to use it)
(import-bob-box)
(import-alice-box)



;Ejemplos
(display "Anchura bob")
(newline)

(display "Altura bob")
(newline)

(display "Area bob")
(newline)

(display "Anchura alice")
(newline)

(display "Altura alice")
(newline)

(display "Area alice")
(newline)