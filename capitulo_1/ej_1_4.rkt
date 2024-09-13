#lang racket

;Observe that our model of evaluation allows for combinations whose operators are compound expressions.  
;Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; The procedure a-plus-abs-b takes two arguments, a and b.
; It uses an if expression to choose between the + and - operators based on the value of b.
; If b is greater than 0, the + operator is chosen.
; If b is less than or equal to 0, the - operator is chosen.

; For example:
; (a-plus-abs-b 3 4) evaluates to (+ 3 4) which is 7.
; (a-plus-abs-b 3 -4) evaluates to (- 3 -4) which is 7.