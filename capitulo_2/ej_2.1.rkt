#lang racket

(define (make-rat x y)  
   (cond
     ((< y 0) (cons x y))
     ((> y 0) (cons (* -1 x) (* -1 y)))
     )
  )


  
(make-rat 1 5)
(make-rat -1 5)
(make-rat -1 -5)
(make-rat 1 -5)
