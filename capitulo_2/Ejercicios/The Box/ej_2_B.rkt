#lang racket
(define (bob-make-box x y w h)
  (list 'bob-box (cons x y) (cons w h)))

(define (bob-width box)
  (car (car (cdr (cdr box)))))

(define (bob-height box)
  (cdr (car (cdr (cdr box)))))



(define (bob-area box)
  (* (bob-width box) (bob-height box)))

(define (alice-make-box x1 y1 x2 y2)
  (list 'alice-box (cons x1 y1) (cons x2 y2)))

(define (alice-width box)
  (let ((x1 (car (car (cdr box))))
        (x2 (car (car (cdr (cdr box))))))
    (abs (- x2 x1))))

(define (alice-height box)
  (let ((y1 (cdr (car (cdr box))))
        (y2 (cdr (car (cdr (cdr box))))))
    (abs (- y2 y1))))



(define (alice-area box)
  (* (alice-width box) (alice-height box)))


(define a (alice-make-box 1 2 3 4))
(alice-area a)    ; Resultado esperado: 4

(define b (bob-make-box 1 2 3 4))
(bob-area b)      ; Resultado esperado: 12

a   ; -> '(alice-box (1 . 2) . (3 . 4))
b   ; -> '(bob-box (1 . 2) . (3 . 4))
