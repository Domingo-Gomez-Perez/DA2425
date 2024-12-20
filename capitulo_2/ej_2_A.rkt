#lang racket

#|

Exercise 2.A: Enter the above code for Bob's and Alice's box. Verify that it works and look at the resulting data structures:

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(alice-area a)
4
(bob-area b)
12

; Look at the resulting data structures
a        -> '((1 . 2) 3 . 4)
b        -> '((1 . 2) 3 . 4)

|#


(define (width box)
  (if (equal? (car box) 'box-bob)
      (bob-width box)
      (alice-width box)))

(define (height box)
  (if (equal? (car box) 'box-bob)
      (bob-height box)
      (alice-height box)))

; Bob's box
(define (bob-make-box x y w h)
  (list 'box-bob (cons x y) (cons w h)))

(define (bob-width box)
   (car(car (cdr (cdr box)))))

(define (bob-height box)
   (cdr(car(cdr (cdr box)))))


(define (bob-area box)
    (* (bob-width box) (bob-height box)))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (list 'box-alice (cons x1 y1) (cons x2 y2)))

(define (alice-width box)
   (abs (- (car (car (cdr box)) )
           (car(car(cdr (cdr box)))))))

(define (alice-height box) 
   (abs (- (cdr(car  (cdr box)) )
          (cdr(car(cdr (cdr box)))))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))

;Ejemplos
(define a (alice-make-box 1 2 3 4))
(alice-width a)
(alice-height a)
(define b (bob-make-box 1 2 3 4))
(alice-area a)
(bob-area b)

(display a)

(display b)