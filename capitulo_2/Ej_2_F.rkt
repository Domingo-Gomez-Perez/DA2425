#lang racket
; Ejercicio 2.F

; BOB
(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) (bob-area width height))
          ((eq? message 'type) 'bob-box)
          )
    )
  dispatch
)

(define (bob-area w h)
    (* w h))

; ALICE

(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (cond ((eq? message 'width) (alice-width x1 x2))
          ((eq? message 'height) (alice-height y1 y2))
          ((eq? message 'area) (alice-area (alice-width x1 x2) (alice-height y1 y2)))
          ((eq? message 'type) 'alice-box)
          )
    )
  dispatch
)

(define (alice-width x y) (abs (- x y)))

(define (alice-height x y) (abs (- x y)))

(define (alice-area w h)
    (* w h))

; Funciones

(define (type box) (box 'type))

(define (width box)
    (box 'width))

(define (height box)
    (box 'height))

(define (area box) (box 'area))

; Example usage:
(define a (make-alice-box 1 2 3 4))
(define b (make-bob-box 1 2 3 4))

(type a)
(width a)
(height a)
(area a)

(type b)
(width b)
(height b)
(area b)