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



(define (bob-box? box)
  (and (pair? box) (eq? (car box) 'bob-box)))

(define (alice-box? box)
  (and (pair? box) (eq? (car box) 'alice-box)))


(define (width box)
  (cond ((bob-box? box) (bob-width box))
        ((alice-box? box) (alice-width box))
        (else (error "Unknown box type: WIDTH" box))))

(define (height box)
  (cond ((bob-box? box) (bob-height box))
        ((alice-box? box) (alice-height box))
        (else (error "Unknown box type: HEIGHT" box))))

(define (area box)
  (cond ((bob-box? box) (bob-area box))
        ((alice-box? box) (alice-area box))
        (else (error "Unknown box type: AREA" box))))

(display "Alice:\n")

(define a (alice-make-box 1 2 3 4))
(width a)   ; Debería retornar 2
(height a)  ; Debería retornar 2
(area a)    ; Debería retornar 4

(display "Bob:\n")
(define b (bob-make-box 1 2 3 4))
(width b)   ; Debería retornar 3
(height b)  ; Debería retornar 4
(area b)    ; Debería retornar 12
