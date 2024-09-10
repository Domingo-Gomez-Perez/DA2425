#lang racket


(define (square a b c)
  (cond ((and (> a b) (> c b)) (+(* a a) (* c c)))
        ((and (> b a) (> c a)) (+(* b b) (* c c)))
        ((and (> a c) (> b c)) (+(* a a) (* b b))))
  )
 
         
