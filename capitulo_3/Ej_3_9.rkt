#lang racket
; Ejercicio 3.9

; factorial recursivo
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6) ; env --> {"n":6}
              ; env --> {"n":6} --> {"n":5}
              ; env --> {"n":6} --> {"n":5} --> {"n":4}
              ; env --> {"n":6} --> {"n":5} --> {"n":4} --> {"n":3} --> {"n":2}
              ; env --> {"n":6} --> {"n":5} --> {"n":4} --> {"n":3} --> {"n":2} --> {"n":1}

; factorial iterativo
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

(factorial 6) ; env --> {"n":6}
              ; env --> {"n":6} --> {"product":1, "counter":1, "max-count":6}
              ; env --> {"n":6} --> {"product":1, "counter":1, "max-count":6} -->
              ; {"product":1, "counter":2, "max-count":6} --> {"product":2, "counter":3, "max-count":6}
              ; --> {"product":6, "counter":4, "max-count":6} -->
              ; {"product":24, "counter":5, "max-count":6} -->
              ; {"product":120, "counter":6, "max-count":6} -->
              ; {"product":720, "counter":7, "max-count":6} --> devuelvo "product"