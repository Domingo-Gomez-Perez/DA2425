#lang racket

; Bob's box
(define (bob-make-box x y w h)
  (attach-tag 'bob-box
              (cons (cons x y) (cons w h))))

(define (bob-width box)
   (car (cdr (contents box))))

(define (bob-height box)
   (cdr (cdr (contents box))))

(define (bob-area box)
    (* (bob-width box) (bob-height box)))

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
    (* (alice-width box) (alice-height box)))

;Ejercicio como tal

(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

(define (bob-box? b) (eq? (type-tag b) 'bob-box))
(define (alice-box? b) (eq? (type-tag b) 'alice-box))


(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(alice-area a)
4
(bob-area b)
12


