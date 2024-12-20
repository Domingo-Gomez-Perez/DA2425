#lang racket

;-----------------------------------------------------
;|                   Ejercicio 2.F                   |
;-----------------------------------------------------
(define (make-box-alice x1 y1 x2 y2)
  (define width (abs (- x2 x1)))
  (define height (abs (- y2 y1)))
  (define (dispatch message)
    (cond
      [(eq? message 'width) width] 
      [(eq? message 'height) height] 
      [(eq? message 'area) (* width height)] 
      [(eq? message 'type) 'alice-box])) 
  dispatch)


(define (make-box-bob x y width height)
  (define (dispatch message)
    (cond
      [(eq? message 'width) width]
      [(eq? message 'height) height]
      [(eq? message 'area) (* width height)] 
      [(eq? message 'type) 'bob-box])) 
  dispatch)

(define a (make-box-alice 1 2 3 4))
(define b (make-box-bob 1 2 3 4)) 

(displayln "Width")
(a 'width)
(b 'width)

(displayln "Height")
(a 'height)
(b 'height)

(displayln "Area")
(a 'area) 
(b 'area) 