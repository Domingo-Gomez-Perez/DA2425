#lang racket
;-----------------------------------------------------
;Para definir el tag
(define (attach-tag tag contents) (cons tag contents))
;El tipo que es
(define (type-tag datum) (car datum))
;El valor que tiene
(define (contents datum) (cdr datum))
;-----------------------------------------------------


;-----------------------------------------------------
;|                   Ejercicio 2.B                   |
;-----------------------------------------------------
;METODOS DE BOB
(define (bob-make-box x y w h)
    (attach-tag 'bob-box
         (cons (cons x y) (cons w h))))

; type-check procedure
(define (bob-box? b) (eq? (type-tag b) 'bob-box))

; Other methods (note: must extract the contents from the tagged value)
(define (bob-width b) (car (cdr (contents b))))
(define (bob-height b) (cdr (cdr (contents b))))
(define (bob-area b)  (* (bob-width b) (bob-height b)))

;METODOS DE ALICE
(define (alice-make-box x y w h)
    (attach-tag 'alice-box
         (cons (cons x y) (cons w h))))

; type-check procedure
(define (alice-box? b) (eq? (type-tag b) 'alice-box))

; Other methods (note: must extract the contents from the tagged value)

(define (alice-width b)
  (abs (- (car (cdr (contents b)))
          (car (car (contents b))))))
(define (alice-height b)
  (abs (- (cdr (cdr (contents b)))
          (cdr (car (contents b))))))
(define (alice-area b)  (* (alice-width b) (alice-height b)))


(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))

a
b
(alice-area a)

(bob-area b)

;-----------------------------------------------------
;|               Procesos Genericos                  |
;-----------------------------------------------------

; Generic procedure
(define (width b)
    (cond ((bob-box? b) (bob-width b))
          ((alice-box? b) (alice-width b))))

; Example
(displayln "Proceso generico de width")
a
b
(width a)
(width b)