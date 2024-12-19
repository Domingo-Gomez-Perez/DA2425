#lang racket

; Generic procedures
(define (width box) (box 'width))
(define (height box) (box 'height))
(define (area box) (box 'area))
(define (type box) (box 'type))


; Bob's box
(define (bob-make-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area)  (* width height))
          ((eq? message 'type) 'bob-box)
          
          )
    )
  dispatch
)


; Alice's box
(define (alice-make-box x1 y1 x2 y2)
  (define width (abs(- x1 x2)))
  (define height (abs(- y1 y2)))
   (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area)  (* width height))
          ((eq? message 'type) 'alice-box)
          
          )
  )
  dispatch
  )



(define a (alice-make-box 1 2 3 4))
(define b (bob-make-box 1 2 3 4))





;Resultados
(area a)
(area b)

(type a)
(type b)



