#lang racket

; Exercise 2.E

; Put the generic "bob" and "alice" functions into their own
; namespace as shown. Point to ponder: Can the procedures for
; creating a bob-box and alice-box also be put into a namespace?

; Basic HashMap methods
(define registry (make-hash))
(define (register name tag proc) (hash-set! registry (list name tag) proc))
(define (lookup name tag) (hash-ref registry (list name tag)))

; Basic tagging methods
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Generical methods
(define (width box) ((lookup 'width (type-tag box)) box))
(define (height box) ((lookup 'height (type-tag box)) box))
(define (area box) ((lookup 'area (type-tag box)) box))


; Bob package
(define (bob-make-box x y w h)
  (attach-tag 'bob-box (cons (cons x y) (cons w h))))

(define (import-bob-box)
  (define (bob-width b)
    (car (cdr (contents b))))
  (define (bob-height b)
    (cdr (cdr (contents b))))
  (define (bob-area b)
    (* (bob-width b) (bob-height b)))

  (register 'width 'bob-box bob-width)
  (register 'height 'bob-box bob-height)
  (register 'area 'bob-box bob-area))


; Alice package
(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))

(define (import-alice-box)
  (define (alice-width b)
    (abs (- (car (cdr (contents b))) (car (car (contents b))))))
  (define (alice-height b)
    (abs (- (cdr (cdr (contents b))) (cdr (car (contents b))))))
  (define (alice-area b)
    (* (alice-width b) (alice-height b)))

  (register 'width 'alice-box alice-width)
  (register 'height 'alice-box alice-height)
  (register 'area 'alice-box alice-area))


; I had to keep the constructors outside to allow access to them. One  
; way to achieve their inclusion could be by creating a general `make-box` 
; function, as we do with the others. However, some changes would need to
; be made to allow choosing between both box implementations.


; Tests:

(import-bob-box)
(import-alice-box)


(display 'Alice-Test:)(newline)
(define a (alice-make-box 1 2 3 4))
(display (width a))(newline)      ; Should return 2
(display (height a))(newline)     ; Should return 2
(display (area a))(newline)       ; Should return 4

(newline)(display 'Bob-Test:)(newline)
(define b (bob-make-box 1 2 3 4))
(display (width b))(newline)      ; Should return 3
(display (height b))(newline)     ; Should return 4
(display (area b))(newline)       ; Should return 12