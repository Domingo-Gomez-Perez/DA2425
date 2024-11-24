
#lang racket
(define (make-box tag contents)
  (cons tag contents))

(define (get-tag box)
  (car box))

(define (get-contents box)
  (cdr box))

; Funciones auxiliares para verificar el tipo de caja
(define (is-bob-box? box)
  (eq? (get-tag box) 'bob-box))

(define (is-alice-box? box)
  (eq? (get-tag box) 'alice-box))

; Funciones para las cajas de Bob
(define (bob-box x y w h)
  (make-box 'bob-box (cons (cons x y) (cons w h))))

(define (bob-width box)
  (car (cdr (get-contents box))))

(define (bob-height box)
  (cdr (cdr (get-contents box))))

(define (bob-area box)
  (* (bob-width box) (bob-height box)))

; Funciones para las cajas de Alice
(define (alice-box x1 y1 x2 y2)
  (make-box 'alice-box (cons (cons x1 y1) (cons x2 y2))))

(define (alice-width box)
  (abs (- (car (cdr (get-contents box))) (car (car (get-contents box))))))

(define (alice-height box)
  (abs (- (cdr (cdr (get-contents box))) (cdr (car (get-contents box))))))

(define (alice-area box)
  (* (alice-width box) (alice-height box)))

; Ejemplo de uso
(define a (alice-box 1 2 3 4)) ; Caja de Alice con (1, 2) a (3, 4)
(define b (bob-box 1 2 3 4))   ; Caja de Bob con (x, y), ancho 3, alto 4

; Mostramos los resultados
(display "Área de la caja de Alice: ")
(display (alice-area a)) ; Debería dar 4
(newline)

(display "Área de la caja de Bob: ")
(display (bob-area b))   ; Debería dar 12
(newline)

(display "Ancho de la caja de Alice: ")
(display (alice-width a)) ; Debería dar 2
(newline)

(display "Alto de la caja de Alice: ")
(display (alice-height a)) ; Debería dar 2
(newline)
