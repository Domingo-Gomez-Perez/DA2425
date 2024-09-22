#lang racket
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (plus a b)
  (if (= a 0) 
      b 
      (inc (plus (dec a) b))))

(define (plus a b)
  (if (= a 0) 
      b 
      (plus (dec a) (inc b))))

;Primera opción (recursiva):
;(plus 4 5)
;(if (= 4 0) 5 (inc (plus (dec 4) 5)))
;(inc (plus (- 4 1) 5))
;(inc (plus 3 5))
;(inc (if (= 3 0) 5 (inc (plus (dec 3) 5))))
;(inc (inc (plus 2 5)))
;(inc (inc (if (= 2 0) 5 (inc (plus (dec 2) 5)))))
;(inc (inc (inc (plus 1 5))))
;(inc (inc (inc (if (= 1 0) 5 (inc (plus (dec 1) 5))))))
;(inc (inc (inc (inc (plus 0 5)))))
;(inc (inc (inc (inc (if (= 0 0) 5 (inc (plus (dec 0) 5)))))))
;(inc (inc (inc (inc 5))))
;(inc (inc (inc (+ 5 1))))
;(inc (inc (inc 6)))
;(inc (inc 7))
;(inc 8)
;9

;Segunda opción (iterativa):
;(plus 4 5)
;(if (= 4 0) 5 (plus (dec 4) (inc 5)))
;(plus (- 4 1) (+ 5 1))
;(plus 3 6)
;(if (= 3 0) 6 (plus (dec 3) (inc 6)))
;(plus 2 7)
;(if (= 2 0) 7 (plus (dec 2) (inc 7)))
;(plus 1 8)
;(if (= 1 0) 8 (plus (dec 1) (inc 8)))
;(plus 0 9)
;(if (= 0 0) 9 (plus (dec 0) (inc 9)))
;9