#lang racket

; Special Exercise

; What answer is given by the following code? Can you explain it?

(define x 5)

(+ (let ((x 3)) (+ x (* x 10)))
    x)

; First the 'x' is defined as a 5. 

; Then we have a 'let' expression that defines 'x' as 3 and this value is used
; to operate (x + 10x) = 11x -> 11*3 = 33.

; Finally, this result is added to the 'x' defined at the beginning (5) -> 33 + 5 = 38.