#lang racket
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Bob's box
(define (bob-make-box x y w h)
  (attach-tag 'bob-box
  (cons (cons x y) (cons w h))))

(define (bob-width box)
   (car (cdr (contents box))))

(define (bob-height box)
   (cdr (cdr (contents box))))

(define (bob-area box)
    (* (width box) (height box)))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (attach-tag 'alice-box
 (cons (cons x1 y1) (cons x2 y2))))

(define (alice-width box)
   (abs (- (car (cdr (contents box)))
           (car (car (contents box))))))

(define (alice-height box)
   (abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box))))))

(define (alice-area box)
    (* (width box) (height box)))

(define (width box)
  (if (eq? (type-tag box) 'bob-box)
      (bob-width box)
      (alice-width box)))

(define (height box)
  (if (eq? (type-tag box) 'bob-box)
      (bob-height box)
      (alice-height box)))

(define (area box)
  (if (eq? (type-tag box) 'bob-box)
      (bob-area box)
      (alice-area box)))


; Ejemplos:
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(area a)
4
(area b)
12

a
b