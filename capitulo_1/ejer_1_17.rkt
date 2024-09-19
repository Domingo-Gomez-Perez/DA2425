#lang racket

(define (halve x) (/ x 2))
(define (double x) (* x 2))

(define (mul a b)

  (define (mul-iter a b c)
    (cond ((= a 1) (+ b c))
          ((even? a) (mul-iter (halve a) (double b) c))
          (else (mul-iter (- a 1) b (+ c b)))))
  
  (mul-iter a b 0))

(mul 5 3) ;15
(mul 2356892374238 823748778234) ;1,941,487,213,707,583,996,735,692