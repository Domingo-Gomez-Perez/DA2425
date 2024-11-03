#lang racket
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

(define a (attach-tag 'int 23))    ; -> (int 23)
(type-tag a)                       ; -> 'int
(contents a)                       ; -> 23

; Bob's box
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

; type-check procedure
(define (bob-box? b) (eq? (type-tag b) 'bob-box))

; Other methods (note: must extract the contents from the tagged value)
(define (bob-width b)
  (car (cdr (contents b))))

(define (bob-height b)
  (cdr (cdr (contents b))))

(define (bob-area b)
    (* (bob-width b) (bob-height b)))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box
              (cons (cons x1 y1) (cons x2 y2))))

; type-check procedure
(define (alice-box? b) (eq? (type-tag b) 'alice-box))

; Other methods
(define (alice-width b)
   (abs (- (car (cdr (contents b)))
           (car (car (contents b))))))

(define (alice-height b)
   (abs (- (cdr (cdr (contents b)))
           (cdr (car (contents b))))))

(define (alice-area b)
    (* (alice-width b) (alice-height b)))

(define a2 (alice-make-box 1 2 3 4))
(define b2 (bob-make-box 1 2 3 4))

(alice-area a2)
; 4
(bob-area b2)
; 12

; Look at the resulting data structures
b2   ; -> '(bob-box (1 . 2) 3 . 4)
a2   ; -> '(alice-box (1 . 2) 3 . 4)