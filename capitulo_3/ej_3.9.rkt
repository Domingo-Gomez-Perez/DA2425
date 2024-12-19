#lang racket
(define (factorial_1 n)
  (if (= n 1)
      1
      (* n (factorial_1 (- n 1)))))

;Cuando se ejecuta (factorial 6) se crea un nuevo ambiente enlazado al global con n = 6, con cada llamada recursiva se crea un nuevo ambiente
;Frame 1: (* 6 factorial (- 6 1) ) ->(* n factorial (5)) -> (* 5 24) -> (120)
;Frame 2: (* 5 factorial (- 5 1) ) ->(* n factorial (4)) -> (* 4 6) -> (24)
;Frame 3: (* 5 factorial (- 4 1) ) ->(* n factorial (3)) -> (* 3 2) -> (6)
;Frame 4: (* 5 factorial (- 3 1) ) ->(* n factorial (2)) -> (* 2 1) -> (2)
;Frame 2: (1)

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
;Con la llamada de (factorial 6) se crea un nuevo ambiente
;frame 1: (fact-iter 1 1 6), la llamada a fact-iter crea otro ambiente y sus llamadas sucesivas
;frame 2: (fact-iter (* 1 1) (+ 1 1) 6) -> (fact-iter 1 2 6)
;frame 3: (fact iter (* 2 1)(+ 2 1) 6) -> (fact-iter 2 3 6)
;frame 4: (fact iter (* 3 2)(+ 3 1) 6) -> (fact-iter 6 4 6)
;frame 5: (fact iter (* 4 6)(+ 4 1) 6) -> (fact-iter 6 5 6)

