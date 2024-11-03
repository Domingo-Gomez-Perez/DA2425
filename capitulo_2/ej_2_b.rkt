#lang racket

; Exercise 2.B

; Modify the "bob" and "alice" code to use tags. Verify
; that all of the old code still works.


(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))


; Bob methods

(define (bob-make-box x y w h)
  (attach-tag 'bob-box
    (cons (cons x y) (cons w h))))

(define (bob-width b)
  (car (cdr (contents b))))

(define (bob-height b)
  (cdr (cdr (contents b))))

(define (bob-area b)
  (* (bob-width b) (bob-height b)))



; Alice methods

(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box
     (cons (cons x1 y1) (cons x2 y2))))

(define (alice-width b)
  (abs (- (car (cdr (contents b))) (car (car (contents b))))))

(define (alice-height b)
  (abs (- (cdr (cdr (contents b))) (cdr (car (contents b))))))

(define (alice-area b)
    (* (alice-width b) (alice-height b)))


; Tests:

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

a                 ; -> '(bob-box (1 . 2) 3 . 4)
b                 ; -> '(alice-box (1 . 2) 3 . 4)

(alice-area a)    ; Should return 4
(bob-area b)      ; Should return 12