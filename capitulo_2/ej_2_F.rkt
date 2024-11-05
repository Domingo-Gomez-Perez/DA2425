#lang racket

#|
**Exercise 2.F:** Reimplement the "alice" and "bob" code as message passing.
|#

(define (make-bob-box x y width height)
  (define (dispatch message)
    (cond ((eq? message 'width) width)
          ((eq? message 'height) height)
          ((eq? message 'area)(bob-area width height))
          ((eq? message 'type) 'bob-box)
          )
    )
  dispatch
)

(define (bob-area width height)
  (* width height))


```

;You already did something like this in Exercise 2.4.  With this approach,
;you now define generic procedures that issue the messages like this:

```
(define (width box)
    (box 'width))

(define (height box)
    (box 'height))

; Example usage for Bob:
(define a (make-bob-box 1 2 3 4))
(a 'width)     ; -> 3
(a 'height)    ; -> 4
(a 'area)
(a 'type)      ; -> 'bob-box


(define (make-alice-box x1  y1 x2 y2)
  (define (alice-width)
   (abs (- x1 x2)))

  (define (alice-height)
    (abs (- y1 y2)))

  (define (alice-area)
    (* (alice-width) (alice-height)))
  (define (dispatch message)
    (cond ((eq? message 'width) (alice-width))
          ((eq? message 'height) (alice-height))
          ((eq? message 'area) (alice-area))
          
          ((eq? message 'type) 'alice-box)
          )
    )
  dispatch
)



(define (contents datum) (cdr datum))


;Example usage for Alice
(define b (make-alice-box 1 2 3 4))
(b'width)     ; -> 3
(b 'height)    ; -> 4
(b 'area)
(b 'type)      ; -> 'bob-box
