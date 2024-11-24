#lang racket
; Constructor bob-box
(define (make-bob-box x y width height)
  (define area (* width height))
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) area)
          ((eq? message 'type) 'bob-box)
    )
  )
  dispatch
)

; Constructor alice-box
(define (make-alice-box x1 y1 x2 y2)
  (define width (abs (- x2 x1)))
  (define height (abs (- y2 y1)))
  (define area (* width height))
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) area)
          ((eq? message 'type) 'alice-box)
    )
  )
  dispatch
)

; Métodos genéricos
(define (width box) (box 'width))
(define (height box) (box 'height))
(define (area box) (box 'area))
(define (type box) (box 'type))

; Comprobar
(define b (make-bob-box 1 2 3 4))   ; crea "objeto" bob-box
(define a (make-alice-box 1 2 3 4)) ; crea "objeto" alice-box
(width a)      ; -> (a 'width)  -> 2
(width b)      ; -> (b 'width)  -> 3
(height a)    ; -> (a 'height) -> 2
(height b)    ; -> (b 'height) -> 4
(area a)       ; -> (a 'area)   -> 4
(area b)       ; -> (b 'area)   -> 12
(type a)      ; -> (a 'type)   -> 'alice-box
(type b)      ; -> (b 'type)   -> 'bob-box
