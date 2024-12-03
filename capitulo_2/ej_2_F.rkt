#lang racket
(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'type) 'bob-box)
          )
    )
  dispatch
)

; Example usage:
(define a (make-bob-box 1 2 3 4))
(a 'width)     ; -> 3
(a 'height)    ; -> 4
(a 'type)      ; -> 'bob-box

(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (cond ((eq? message 'width) (abs (- x1 x2)))
          ((eq? message 'height) (abs (- y1 y2)))
          ((eq? message 'type) 'alice-box)
          )
    )
  dispatch
)

; Example usage:
(define b (make-alice-box 1 2 3 4))
(b 'width)     ; -> 2
(b 'height)    ; -> 2
(b 'type)      ; -> 'alice-box

(define (width box)
    (box 'width))

(define (height box)
    (box 'height))

(define (type box)
    (box 'type))

(width a) ; -> 3
(width b) ; -> 2
(height a) ; -> 4
(height b) ; -> 2
(type a) ; -> 'bob-box
(type b) ; -> 'alice-box