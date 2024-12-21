#lang racket
; Ejercicio 2.E

; BOB
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

(define (bob-box? box) (
        equal? (type-tag box) 'bob-box
    )
)

(define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) (cdr (cdr (contents b))))

(define (bob-area box)
    (* (bob-width box) (bob-height box)))

; ALICE
(define (alice-make-box x1 y1 x2 y2)(
        attach-tag 'alice-box (cons (cons x1 y1) (cons x2 y2))
    )
)

(define (alice-box? box) (
        equal? (type-tag box) 'alice-box
    )
)

(define (alice-width box)
   (abs (- (car (cdr (contents box)))
           (car (car (contents box))))))

(define (alice-height box)
   (abs (- (cdr (cdr (contents box)))
           (cdr (car (contents box))))))

(define (alice-area box)
    (* (alice-width box) (alice-height box)))

; TAG
(define (attach-tag tag contents) (cons tag contents))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

; Mapa
(define reg-bob (make-hash))

(define (register-bob name tag proc)
   (hash-set! reg-bob (list name tag) proc))

(define (lookup-bob name tag)
   (hash-ref reg-bob (list name tag)))

(define reg-alice (make-hash))

(define (register-alice name tag proc)
   (hash-set! reg-alice (list name tag) proc))

(define (lookup-alice name tag)
   (hash-ref reg-alice (list name tag)))

; Modulos

(define (import-bob-box)
   (define (width box)(
       (lookup-bob 'width (type-tag box)) box))
   (define (height box)(
       (lookup-bob 'height (type-tag box)) box))
   (register-bob 'width 'bob-box bob-width)
   (register-bob 'height 'bob-box bob-height)
)

(define (import-alice-box)
   (define (width box)(
       (lookup-alice 'width (type-tag box)) box))
   (define (height box)(
       (lookup-alice 'height (type-tag box)) box))
   (register-alice 'width 'alice-box alice-width)
   (register-alice 'height 'alice-box alice-height)
   ;width
   ;height
)

; Ejemplos
;reg-bob
;reg-alice

(import-bob-box)
(import-alice-box)

(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

(width a)