#lang racket
;Ejercicio 3.9

;Recursive
(define (factorialr n)
  (if (= n 1)
      1
      (* n (factorialr (- n 1)))))

;para (factorialr 2)

;env glob --> codigo
;env factorialr 2 --> codigo | n = 2

;env glob --> codigo
;env factorialr 2 --> codigo | n = 2
;env factorialr 1 --> codigo | n = 1

;env glob --> codigo
;env factorialr 2 --> codigo | n = 2
;env factorialr 1 --> codigo | n = 1 |resultado: 1
 
;env glob --> codigo
;env factorialr 2 --> codigo | n = 2 |resultado: 2



;Iterative
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;env glob --> codigo
;env factorial --> codigo | n = 2

;env glob --> codigo
;env factorial --> codigo | n = 2
;env fact-iter --> codigo | product = 1 counter = 1 max-count = 2

;env glob --> codigo
;env factorial --> codigo | n = 2
;env fact-iter --> codigo | product = 1 counter = 2 max-count = 2

;env glob --> codigo
;env factorial --> codigo | n = 2
;env fact-iter --> codigo | product = 2 counter = 3 max-count = 2
