#lang racket
;Ejercicio 2.E

(define registry (make-hash))

(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

(define (lookup name object)
  (hash-ref registry (list name (type-tag object))))

(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

;Bob's box


(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

(define (import-bob-box)
  (define (width box) (car (cdr (contents box))))
  (define (height box) (cdr (cdr (contents box))))
  (define (area box) (* (width box) (height box)))

(register 'width 'bob-box width)
(register 'height 'bob-box height)
(register 'area 'bob-box area))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))

(define (alice-box? b) (eq? (type-tag b) 'alice-box))

(define (import-alice-box)
  (define (width box) (abs (- (car (cdr (contents box))) (car (car (contents box))))))
  (define (height box) (abs (- (cdr (cdr (contents box))) (cdr (car (contents box))))))
  (define (area box) (* (width box) (height box)))

(register 'width 'alice-box width)
(register 'height 'alice-box height)
(register 'area 'alice-box area))

; Generic procedure
(define (width b) ((lookup 'width b) b))
(define (height b) ((lookup 'height b) b))
(define (area b) ((lookup 'area b) b))

(import-bob-box)
(import-alice-box)

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(width a)
(width b)
(height a)
(height b)
(area a)
(area b)