#lang racket
(define (sum-of-squares-of-larger-two a b c)
    (cond
    [(and (<= a b) (<= a c)) (+ (* b b) (* c c))]  ; a es el más pequeño
    [(and (<= b a) (<= b c)) (+ (* a a) (* c c))]  ; b es el más pequeño
    [else (+ (* a a) (* b b))]))                  ; c es el más pequeño


(sum-of-squares-of-larger-two 3 5 1) ; 9 + 25 = 34
(sum-of-squares-of-larger-two 3 5 4) ; 25 + 16 = 41
(sum-of-squares-of-larger-two 3 1 7) ; 9 + 49 = 58


