#lang racket
;Ejercicio 2.F

;Bob's box
(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area) (* width height))
          ((eq? message 'type) 'bob-box)))
  dispatch)




;Alice's box
(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (let ((width (abs (- x2 x1)))
          (height (abs (- y2 y1))))
      (cond ((eq? message 'width) width)
            ((eq? message 'height) height)
            ((eq? message 'area) (* width height))
            ((eq? message 'type) 'alice-box))))
  dispatch)


;Generic Procedures

(define (width box)(box 'width))

(define (height box)(box 'height))

(define (area box)(box 'area))

(define (box-type box)(box 'type))



(define b (make-bob-box 1 2 3 4))    
(define a (make-alice-box 1 2 3 4)) 


(width b)
(width a) 
(height b)
(height a)
(area b)
(area a)
(box-type b)
(box-type a) 

