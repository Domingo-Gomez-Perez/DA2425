#lang racket
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Bob's box
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

(define (bob-box? b) (eq? (type-tag b) 'bob-box))

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

(define (alice-box? b) (eq? (type-tag b) 'alice-box))

(define (alice-width b)
   (abs (- (car (cdr (contents b)))
           (car (car (contents b))))))

(define (alice-height b)
   (abs (- (cdr (cdr (contents b)))
           (cdr (car (contents b))))))

(define (alice-area b)
    (* (alice-width b) (alice-height b)))

; Generic procedure (width)
(define (width b)
    (cond ((bob-box? b) (bob-width b))
          ((alice-box? b) (alice-width b))))

; Generic procedure (height)
(define (height b)
    (cond ((bob-box? b) (bob-height b))
          ((alice-box? b) (alice-height b))))

; Generic procedure (area)
(define (area b)
    (cond ((bob-box? b) (bob-area b))
          ((alice-box? b) (alice-area b))))

; Comprobar
(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)  ; -> 2
(width b)  ; -> 3
(height a) ; -> 2
(height b) ; -> 4
(area a)   ; -> 4
(area b)   ; -> 12
