#lang racket
; Ejercicio 2.E

; BOB
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

(define (import-bob-box)
   (define (bob-width box)(
       car (cdr (contents b)))
    )
   (define (bob-height box)(
       cdr (cdr (contents b)))
    )
   (define (bob-area box) (* (bob-width box) (bob-height box)))
   (register 'width 'bob-box bob-width)
   (register 'height 'bob-box bob-height)
   (register 'area 'bob-box bob-area)
)

;(define (bob-box? box) (
;        equal? (type-tag box) 'bob-box
;    )
;)

;(define (bob-width b) (car (cdr (contents b))))
;(define (bob-height b) (cdr (cdr (contents b))))

;(define (bob-area box)
;    (* (bob-width box) (bob-height box)))

; ALICE
(define (alice-make-box x1 y1 x2 y2)(
        attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))
    )
)

(define (import-alice-box)
   (define (alice-width box)(
       abs (- (car (cdr (contents box)))
           (car (car (contents box)))))
   )
   (define (alice-height box)(
       abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box)))))
   )
   (define (alice-area box) (* (alice-width box) (alice-height box)))
   (register 'width 'alice-box alice-width)
   (register 'height 'alice-box alice-height)
   (register 'area 'alice-box alice-area)
)

     
;(define (alice-box? box) (
;        equal? (type-tag box) 'alice-box
;    )
;)

;(define (alice-width box)
;   (abs (- (car (cdr (contents box)))
;           (car (car (contents box))))))

;(define (alice-height box)
;   (abs (- (cdr (cdr (contents box)))
;           (cdr (car (contents box))))))

;(define (alice-area box)
;    (* (alice-width box) (alice-height box)))

; TAG
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Mapa
(define reg (make-hash))

(define (register name tag proc)
   (hash-set! reg (list name tag) proc))

(define (lookup name tag)
   (hash-ref reg (list name tag)))

; Declaración de métodos

(define (width box) ((lookup 'width (type-tag box)) box))
(define (height box) ((lookup 'height (type-tag box)) box))
(define (area box) ((lookup 'area (type-tag box)) box))

; Ejemplos

(import-bob-box)
(import-alice-box)

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)
(height b)
(area a)
(area b)