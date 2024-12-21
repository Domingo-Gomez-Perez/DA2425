#lang racket

;-----------------------------------------------------
;Para definir el tag
(define (attach-tag tag contents) (cons tag contents))
;El tipo que es
(define (type-tag datum) (car datum))
;El valor que tiene
(define (contents datum) (cdr datum))
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

;------------------------------------------------------

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

;------------------------------------------------------

;-----------------------------------------------------
;|                   Ejercicio 2.C                   |
;-----------------------------------------------------
(define (width b)
    (cond ((bob-box? b) (bob-width b))
          ((alice-box? b) (alice-width b))))

(define (height b)
    (cond ((bob-box? b) (bob-height b))
          ((alice-box? b) (alice-height b))))

(define (area b)
    (cond ((bob-box? b) (bob-area b))
          ((alice-box? b) (alice-area b))))


