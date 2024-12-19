#lang racket
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))

; (inc (plus (dec 4) 5))
; (inc (plus (- 4 1)))
; (inc (plus 3 5))
; (inc (inc (plus (dec 3) 5)))
; (inc (inc (plus 2 5)))
; (inc (inc (inc (plus (dec 2) 5))))
; (inc (inc (inc (plus 1 5))))
; (inc (inc (inc (inc (plus (dec 1) 5)))))
; (inc (inc (inc (inc (plus 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc (+ 5 1))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

(plus 4 5)

(define (plus1 a b)
  (if (= a 0) 
      b 
      (plus1 (dec a) (inc b))))

; (plus1 (dec 4) (inc 5))
; (plus1 (- 4 1) (+ 5 1))
; (plus1 3 6)
; (plus1 (dec 3) (inc 6))
; (plus1 2 7)
; (plus1 (dec 2) (inc 7))
; (plus1 1 8)
; (plus1 (dec 1) (inc 8))
; (plus1 0 9)
; 9

(plus1 4 5)