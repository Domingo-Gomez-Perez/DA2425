#lang racket

(define (bob-make-box x y w h)
  (lambda (message)
    (cond 
      ((eq? message 'width) w)
      ((eq? message 'height) h)
      ((eq? message 'area) (* w h))
      )))


(define (alice-make-box x1 y1 x2 y2)
  (lambda (message)
    (let ((width (abs (- x2 x1)))
          (height (abs (- y2 y1))))
      (cond
        ((eq? message 'width) width)
        ((eq? message 'height) height)
        ((eq? message 'area) (* width height))
        ))))

(define (width box)
  (box 'width))

(define (height box)
  (box 'height))

(define (area box)
  (box 'area))

; Ejemplos:

;Creamos caja de bob
(define bob-box (bob-make-box 0 0 5 10))

(width bob-box)  ; Deberia dovolver 5
(height bob-box) ; Deberia dovolver 10
(area bob-box)   ; Deberia dovolver 50

;Creamos caja de alice
(define alice-box (alice-make-box 1 1 4 5))

(width alice-box)  ; Deberia dovolver 3
(height alice-box) ; Deberia dovolver 4
(area alice-box)   ; Deberia dovolver 12