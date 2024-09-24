#lang racket


(define (sumatres a b c)
  (if(> a b)
     (if (> b c)
         (+(* a a) (* b b))
         (+(* a a) (* c c)))
     (if (> a c)
         (+(* a a) (* b b))
         (+(* b b) (* c c)))))