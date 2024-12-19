#lang racket
(define (square a) (* a a))
(define (next x) (+ 1 x))

#|
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
  
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        0
        (iter ⟨??⟩ ⟨??⟩)))
  (iter ⟨??⟩ ⟨??⟩))
|#

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(sum square 1 next 4)