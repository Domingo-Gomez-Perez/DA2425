#lang racket

(define (bob-make-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'type) 'bob-box)
          ((eq? message 'area) (* width height))
		  ((eq? message 'x) x)
		  ((eq? message 'y) y)

          )
    )
  dispatch
)

; ; Crear una caja de Alice
; (define (alice-make-box x1 y1 x2 y2) 
;   (attach-tag 'alice-box
;               (cons (cons x1 y1) (cons x2 y2))))

(define (alice-make-box x1 y1 x2 y2)
  (define (dispatch message)
    (cond ((eq? message 'width) (abs(- x1 x2)))
          ((eq? message 'height) (abs (- y1 y2)))
          ((eq? message 'type) 'alice-box)
          ((eq? message 'area) (* (abs(- x1 x2)) (abs (- y1 y2))))
		  ((eq? message 'x) x1)
		  ((eq? message 'y) y1)
          )
    )
  dispatch
)

; Crear instancias de cajas
(define a (alice-make-box 1 2 3 4)) ; Crea una caja de Alice
(define b (bob-make-box 1 2 3 4))    ; Crea una caja de Bob


(newline)

;Verificar el comportamiento correcto

(displayln (format "Box A: Type = ~a,Width = ~a, Height = ~a, Area = ~a" 
                   (a 'type) (a 'width) (a 'height) (a 'area)))

(displayln (format "Box B: Type = ~a,Width = ~a, Height = ~a, Area = ~a" 
                   (b 'type) (b 'width) (b 'height) (b 'area)))
(newline)


; Example usage:
(define r (bob-make-box 1 2 3 4))
(r 'width)     ; -> 3
(r 'height)    ; -> 4
(r 'type)      ; -> 'bob-box


(define (height box)
    (box 'height))
(define (width box)
    (box 'width))
(define (area box)
    (box 'area))
