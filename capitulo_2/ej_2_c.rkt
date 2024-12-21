#lang racket

; Exercise 2.C

; Write generic procedures for `width`, `height`, and
; `area`.  Verify correct behavior.


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
  



; General methods

(define (width box)
  (cond
    ((equal? (type-tag box) 'bob-box) (bob-width box))
    ((equal? (type-tag box) 'alice-box) (alice-width box))
    (else null)))

(define (height box)
  (cond
    ((equal? (type-tag box) 'bob-box) (bob-height box))
    ((equal? (type-tag box) 'alice-box) (alice-height box))
    (else null)))

(define (area box)
  (cond
    ((equal? (type-tag box) 'bob-box) (bob-area box))
    ((equal? (type-tag box) 'alice-box) (alice-area box))
    (else null)))


; Tests:

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(display 'Width)(newline)
(alice-width a)    ; Should return 2
(width a)          ; Should return 2
(bob-width b)      ; Should return 3
(width b)          ; Should return 3

(newline)(display 'Height)(newline)
(alice-height a)   ; Should return 2
(height a)         ; Should return 2
(bob-height b)     ; Should return 4
(height b)         ; Should return 4

(newline)(display 'Area)(newline)
(alice-area a)     ; Should return 4
(area a)           ; Should return 4
(bob-area b)       ; Should return 12
(area b)           ; Should return 12