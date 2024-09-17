#lang racket
(define (suma-de-cuadrados-grandes x y z)
  (cond ((and (<= x y) (<= x z)) (+ (* y y) (* z z))) 
        ((and (<= y x) (<= y z)) (+ (* x x) (* z z)))  
        (else (+ (* x x) (* y y)))))

(suma-de-cuadrados-grandes 2 3 4)