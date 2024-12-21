#lang racket

(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name object)
   (hash-ref registry (list name object)))

; Bob's box
(define (import-bob-box)
  (define (width box)
    (car (cdr (contents box))))
  (define (height box)
    (cdr (cdr (contents box))))
  (define (area box)
    (* (width box) (height box)))
  (define (bob-box? b) (eq? (type-tag b) 'bob-box))
  (register 'width 'bob-box width)
  (register 'height 'bob-box height)  
  )

(define (bob-make-box x y w h)
  (attach-tag 'bob-box
              (cons (cons x y) (cons w h))))

; Alice's box
(define (import-alice-box)
  (define (width box)
    (abs (- (car (cdr (contents box)))
            (car (car (contents box))))))  
  (define (height box)
    (abs (- (cdr (cdr (contents box)))
            (cdr (car (contents box))))))
  (define (area box)
    (* (width box) (height box)))
  (define (alice-box? b) (eq? (type-tag b) 'alice-box))
  (register 'width 'alice-box width)
  (register 'height 'alice-box height)
  )

(define (alice-make-box x1 y1 x2 y2)
  (attach-tag 'alice-box
              (cons (cons x1 y1) (cons x2 y2))))




(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

;Pruebas:

(import-alice-box)

(define a (alice-make-box 1 2 3 4))
;(define b (bob-make-box 1 2 3 4))
(width a)
2
;(width b)
;3


