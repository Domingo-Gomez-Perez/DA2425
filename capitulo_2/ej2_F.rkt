#lang racket
;Bob's box
(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width) ;ancho
          ((eq? message 'height) height) ;altura
          ((eq? message 'area) (* width height)) ;area
          ((eq? message 'type) 'bob-box))) ;tipo de caja
  dispatch)

;Alice's box
(define (make-alice-box x1 y1 x2 y2)
  (define (dispatch message)
    (let ((width (abs (- x2 x1)))
          (height (abs (- y2 y1))))
      (cond ((eq? message 'width) width) ;ancho
            ((eq? message 'height) height) ;altura 
            ((eq? message 'area) (* width height)) ;area
            ((eq? message 'type) 'alice-box)))) ;tipo de caja
  dispatch)

(define b (make-bob-box 1 2 3 4)) ;Caja de Bob   
(define a (make-alice-box 1 2 3 4)) ;Caja de Alice

;Generic Procedures
(define (width box)(box 'width))
(define (height box)(box 'height))
(define (area box)(box 'area))

;Pruebas de ambas cajas
(width b)
(width a) 
(height b)
(height a)
(area b)
(area a)
