#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; El procedimiento a-plus-abs-b hace la siguiente operación:
;    a + |b| -> a + abs(b) -> (+ a abs(b)) ->
;    (if (> b 0) (+ a b) (- a b)) ->
;    (if (> b 0) + -) a b)
; En pseudocódigo:
;    a-plus-abs-b(a,b)
;      return a + b if b > 0 else a - b

(a-plus-abs-b 2 4)
(a-plus-abs-b 2 -4)