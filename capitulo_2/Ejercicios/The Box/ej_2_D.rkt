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

(define registry (make-hash))

(define (register name tag proc)
   (hash-set! registry (list name tag) proc))

(define (lookup name object)
   (hash-ref registry (list name object)))

(define (bob-box? box)
  (and (pair? box) (eq? (car box) 'bob-box)))

(define (alice-box? box)
  (and (pair? box) (eq? (car box) 'alice-box)))


(define (type-tag box)
  (cond ((bob-box? box) 'bob-box)
        ((alice-box? box) 'alice-box)
        (else (error "Unknown box type: WIDTH" box))))

; Register procedures (in advance)
(register 'width 'bob-box bob-width)
(register 'width 'alice-box alice-width)
(register 'height 'bob-box bob-height)
(register 'height 'alice-box alice-height)

; Generic procedure
(define (width box)
    ((lookup 'width (type-tag box)) box))
(define (height box)
    ((lookup 'height (type-tag box)) box))

(define (area box)
    (* (width box) (height box)))


(display "Alice:\n")
(define a (alice-make-box 1 2 3 4))
(display "Ancho:")
(width a)   ; Debería retornar 2
(display "Alto:")
(height a)  ; Debería retornar 2
(display "Area:")
(area a)    ; Debería retornar 4

(display "\n")

(display "Bob:\n")
(define b (bob-make-box 1 2 3 4))
(display "Ancho:")
(width b)   ; Debería retornar 3
(display "Alto:")
(height b)  ; Debería retornar 4
(display "Area:")
(area b)    ; Debería retornar 12