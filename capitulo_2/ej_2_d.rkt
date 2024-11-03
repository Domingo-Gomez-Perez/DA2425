#lang racket

; Exercise 2.D

; A registry to your code.  Register various width/height procedures
; with the registry.  Write generic width/height/area procedures.


; Basic HashMap methods
(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name tag)
   (hash-ref registry (list name tag)))


; Basic tagging methods
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



; Register methods
(register 'width 'bob-box bob-width)
(register 'width 'alice-box alice-width)

(register 'height 'bob-box bob-height)
(register 'height 'alice-box alice-height)

(register 'area 'bob-box bob-area)
(register 'area 'alice-box alice-area)


(define (width box)
    ((lookup 'width (type-tag box)) box))

(define (height box)
    ((lookup 'height (type-tag box)) box))

(define (area box)
    ((lookup 'area (type-tag box)) box))



; Tests:
(display 'Alice-Test:)(newline)
(define a (alice-make-box 1 2 3 4))
(width a)      ; Should return 2
(height a)     ; Should return 2
(area a)       ; Should return 4

(newline)(display 'Bob-Test:)(newline)
(define b (bob-make-box 1 2 3 4))
(width b)      ; Should return 3
(height b)     ; Should return 4
(area b)       ; Should return 12