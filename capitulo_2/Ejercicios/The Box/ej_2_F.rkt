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


(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (cond ((eq? message 'width) (abs (- x2 x1)))
          ((eq? message 'height) (abs (- y2 y1)))
          ((eq? message 'type) 'alice-box)
          )
    )
  dispatch
)

(define (width box)
    (box 'width))

(define (height box)
    (box 'height))

(define (area box)
    (* (width box) (height box)))


(display "Bob:\n")
(define b (make-bob-box 1 2 3 4))
(display "Ancho:")
(width b)   ; Debería retornar 3
(display "Alto:")
(height b)  ; Debería retornar 4
(display "Area:")
(area b)    ; Debería retornar 12


(display "\n")

(display "Alice:\n")
(define a (make-alice-box 1 2 3 4))
(display "Ancho:")
(width a)   ; Debería retornar 2
(display "Alto:")
(height a)  ; Debería retornar 2
(display "Area:")
(area a)    ; Debería retornar 4



