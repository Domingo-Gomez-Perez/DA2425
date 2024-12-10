#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.F: Reimplement the "alice" and "bob" code as message passing.
|#

; Caja de Alice, definida por las esquinas (x1, y1) y (x2, y2).
(define (make-box-alice x1 y1 x2 y2)
  (define width (abs (- x2 x1))) ; Calcula el ancho
  (define height (abs (- y2 y1))) ; Calcula la altura
  (define (dispatch message)
    (cond
      [(eq? message 'width) width] ; Responde con el ancho
      [(eq? message 'height) height] ; Responde con la altura
      [(eq? message 'area) (* width height)] ; Responde con el área
      [(eq? message 'type) 'alice-box])) ; Responde con el tipo de caja
  dispatch)

; Caja de Bob, definida por una esquina inferior izquierda (x, y) y dimensiones de ancho y altura.
(define (make-box-bob x y width height)
  (define (dispatch message)
    (cond
      [(eq? message 'width) width] ; Responde con el ancho
      [(eq? message 'height) height] ; Responde con la altura
      [(eq? message 'area) (* width height)] ; Responde con el área
      [(eq? message 'type) 'bob-box])) ; Responde con el tipo de caja
  dispatch)

; PRUEBAS

(define a (make-box-alice 1 2 3 4)) ; Crear caja de Alice
(define b (make-box-bob 1 2 3 4)) ; Crear caja de Bob

; Consultar propiedades de la caja de Alice
(a 'width) ; Ancho de Alice
(a 'height) ; Altura de Alice
(a 'area) ; Área de Alice

(newline)

; Consultar propiedades de la caja de Bob
(b 'width) ; Ancho de Bob
(b 'height) ; Altura de Bob
(b 'area) ; Área de Bob
