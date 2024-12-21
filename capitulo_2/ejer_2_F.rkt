#lang racket
(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'type) 'bob-box)
          ((eq? message 'area) (* height width))
          )
    )
  dispatch
)

(define (make-alice-box x1 y1 x2 y2)
  (define real-width (abs (- x1 x2)))
  (define real-height (abs (- y1 y2)))
  (define (dispatch message)
    (cond ((eq? message 'width) real-width)
          ((eq? message 'height) real-height)
          ((eq? message 'type) 'alice-box)
          ((eq? message 'area) (* real-width real-height))
          )
    )
  dispatch
)

; Example usage:
(define b (make-bob-box 1 2 3 4))
(b 'width)     ; -> 3
(b 'height)    ; -> 4
(b 'type)      ; -> 'bob-box
(b 'area)      ; -> 3*4=12

(define a (make-alice-box 1 2 3 4))
(a 'width)     ; -> 2
(a 'height)    ; -> 2
(a 'type)      ; -> 'alice-box
(a 'area)      ; -> 4