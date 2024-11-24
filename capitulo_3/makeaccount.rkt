#lang racket

(define (make-account balance)
  (define (sacar x)
    (set! balance (- balance x))
    (displayln balance)
    )
  (define (ingresar x)
    (set! balance (+ balance x))
    (displayln balance)
    )
  (define (dispatch mensaje)
    (cond ((eq? mensaje 'sacar) sacar)
          ((eq? mensaje 'ingresar) ingresar)))
  dispatch)

(define cuenta1 (make-account 100))
((cuenta1 'ingresar) 100)
((cuenta1 'sacar) 150)


;Ejercicio1
(define (make-accumulator x)
  (define (dispatch y)
    (display (+ x y)))
  dispatch)

  

