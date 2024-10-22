#lang racket


(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))



(define (fast-mul a b)
  (cond (= b 0)
        0
        ((even? b)
         (fast-mul (* a a) (/ b 2)))
        (else
         (+ a (fast-mul a (- b 1))))))