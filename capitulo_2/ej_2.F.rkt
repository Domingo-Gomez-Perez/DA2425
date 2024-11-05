#lang racket

#|
Hecho por 
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.F: Reimplement the "alice" and "bob" code as message passing.

|#

; la caja de alice
(define (make-box-alice x1 y1 x2 y2)
  (define width (abs(- x2 x1)))
  (define height (abs(- y2 y1)))
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) (* width height))
          ((eq? message 'type) 'alice-box)
          )
    )
  dispatch
)

; la caja de bob
(define (make-box-bob x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) (* width height))
          ((eq? message 'type) 'bob-box)
          )
    )
  dispatch
)


;PRUEBAS

(define a (make-box-alice 1 2 3 4))
(define b (make-box-bob 1 2 3 4))

(a 'width)
(a 'height)
(a 'area)

(newline)
(b 'width)
(b 'height)
(b 'area)


  
