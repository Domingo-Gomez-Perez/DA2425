#lang racket
(define (lsqsum x y z)
  (define m (min x y z))
  (cond ((and (not (= x m)) (not (= y m))) (+ (* x x) (* y y)))
        ((and (not (= x m)) (not (= z m))) (+ (* x x) (* z z)))
        ((and (not (= y m)) (not (= z m))) (+ (* y y) (* z z)))))

(lsqsum 2 3 4)
