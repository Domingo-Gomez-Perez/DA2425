#lang racket
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))


; Frame 1: (* 6 120) = 720  n=6
; Frame 2: (* 5 24) = 120   n=5
; Frame 3: (* 4 6) = 24     n=4
; Frame 4: (* 3 2) = 6      n=3
; Frame 5: (* 2 1) = 2      n=2
; Frame 6: 1                n=1

(define (factorial1 n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

(factorial1 6)


; Frame 1: (factorial 6)       
; Frame 2: (fact-iter 1 1 6)  
; Frame 3: (fact-iter 1 2 6)   counter=1
; Frame 4: (fact-iter 2 3 6)   counter=2
; Frame 5: (fact-iter 6 4 6)   counter=3
; Frame 6: (fact-iter 24 5 6)  counter=4
; Frame 7: (fact-iter 120 6 6) counter=5
; Frame 8: (fact-iter 720 7 6) counter=6
; Frame 9: 720                 counter=7