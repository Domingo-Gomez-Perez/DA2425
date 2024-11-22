#lang racket

(define (make-box x y w h)
  (cons (cons x y) (cons w h)))

(define (width box)
   (car (cdr box))

(define (height box)
   (cdr (cdr box))

(define (area box)
    (* (width box) (height box))
 
(define (make-box x1 y1 x2 y2)
 (cons (cons x1 y1) (cons x2 y2)))

(define (width box)
   (abs (- (car (cdr box))
           (car (car box)))))

(define (height box)
   (abs (- (cdr (cdr box))
           (cdr (car box)))))

(define (area box)
    (* (width box) (height box))

  
; Bob's box
(define (bob-make-box x y w h)
  (cons (cons x y) (cons w h)))

(define (bob-width box)
   (car (cdr box))

(define (bob-height box)
   (cdr (cdr box))

(define (bob-area box)
    (* (width box) (height box))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
 (cons (cons x1 y1) (cons x2 y2)))

(define (alice-width box)
   (abs (- (car (cdr box))
           (car (car box)))))

(define (alice-height box)
   (abs (- (cdr (cdr box))
           (cdr (car box)))))

(define (alice-area box)
    (* (width box) (height box))

  
(define (height-bob box)
  cdr (cdr box))

(define (make-box-alice x1 y1 x2 y2)
  (cons (cons x1 y1) (cons x2 y2)))

(define (width-alice box)
  (- (car (cdr box)) (car (car box))))



