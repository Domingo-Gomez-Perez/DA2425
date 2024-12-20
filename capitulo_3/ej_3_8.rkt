#lang racket


;define una variable global con valor 0
(define valor 0)

;Es una funcion que suma a valor x 
;(define (p x)
;  (set! valor (+ valor x))
;  valor
;  )

;(+ (p 0) (p 1)) --> 1
;(+ (p 1) (p 0)) --> 2

(define (f x)
  (cond
    ((and (= valor 0) (= x 0)) (set! valor -1))    
    ((and (= valor 0) (= x 1)) (set! valor 1))
    ((and (= valor -1) (= x 1))(set! valor 1))
    ((and (= valor 1) (= x 0)) (set! valor 0))
      )
  valor
  )


(+ (f 1) (f 0)) ;-->1
(+ (f 0) (f 1)) ;-->0


