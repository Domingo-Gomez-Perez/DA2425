#lang racket
(define y 0)
(define (f x)
  (set! x(* x y))
   (if ( = y 0)
     (set! y 1)
     (set! y 0)    
     )
  x
  
)

(+ (f 1) (f 0))
(+ (f 0) (f 1))