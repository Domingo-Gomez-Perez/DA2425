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


(define (width box)
    ((lookup 'width (type-tag box)) box))
   (define (height box)
    ((lookup 'height (type-tag box)) box))
  (define (area box)
    ((lookup 'area (type-tag box)) box))

(define (bob-make-box x y w h)
  (attach-tag 'bob-box (cons (cons x y) (cons w h))))

(define (import-bob-box)
  
  (define (bob-width box)
   (car (cdr (contents box))))

(define (bob-height box)
   (cdr (cdr (contents box))))
  (define (bob-area box)
    (* (bob-width box) (bob-height box)))
   
   (register 'width 'bob-box bob-width)
   (register 'height 'bob-box bob-height)
  (register 'area 'bob-box bob-area)
)



(define (alice-make-box x1 y1 x2 y2)
 (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))

(define (import-alice-box)
  
  (define (alice-width box)
   (abs (- (car (cdr (contents box)))
           (car (car (contents box))))))

(define (alice-height box)
   (abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box))))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))
  
    (register 'width 'alice-box alice-width)
   (register 'height 'alice-box alice-height)
  (register 'area 'alice-box alice-area)
)

; Explicit import (in code that wants to use it)
(import-bob-box)
(import-alice-box)

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))


;Ejemplos
(display "Anchura bob")
(newline)
(width b)

(display "Altura bob")
(newline)
(height b)

(display "Area bob")
(newline)
(area b)

(display "Anchura alice")
(newline)
(width a)

(display "Altura alice")
(newline)
(height a)

(display "Area alice")
(newline)
(area a)