#lang racket

(define registry (make-hash))

(define (register name tag proc)
  (hash-set! registry (list name tag) proc))

(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

;Bob's box
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

; Espacio de nombres de Bob
(define (import-bob-box)
  (define (width box)
    (car (cdr (contents box))))
  (define (height box)
    (cdr (cdr (contents box))))
  (define (area box)
    (* (width b) (height b)))
  (register 'width 'bob-box width)
  (register 'height 'bob-box height)
  (register 'area 'bob-box area))

; Alice's box
(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))))

; Espacio de nombres de Alice
(define (import-alice-box)
  (define (width box)
      (abs (- (car (cdr (contents b)))
          (car (car (contents b))))))
  (define (height box)
      (abs (- (cdr (cdr (contents b)))
          (cdr (car (contents b))))))
  (define (area box)
    (* (width b) (height b)))
  (register 'width 'alice-box width)
  (register 'height 'alice-box height)
  (register 'area 'alice-box area))


(define (lookup name object)
  (hash-ref registry (list name (type-tag object))))
; Generic procedure area
(define (area b) ((lookup 'area b) b))
; Generic procedure width
(define (width b) ((lookup 'width b) b))
; Generic procedure height
(define (height b) ((lookup 'height b) b))

(import-bob-box)
(import-alice-box)

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))
(width a) ;2
(width b) ;3
(height a) ;2
(height b) ;4
(area a) ;4
(area b) ;12
