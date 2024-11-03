#lang racket

; | y     <- width ->
; |       +---------+   ^
; |       |         |   |
; |       |         | height
; |       |         |   |
; |       +---------+   v
; |     (x,y)
; |______________________________ x

(define (make-box x y w h)
  (cons (cons x y) (cons w h)))

(define (width box)
   (car (cdr box)))

(define (height box)
   (cdr (cdr box)))

(define (area box)
    (* (width box) (height box)))

(define (make-box-alice x1 y1 x2 y2)
  (cons (cons x1 y1) (cons x2 y2)))

(define (width-alice box)
  (- (car ( cdr box) ) (car (car box))))