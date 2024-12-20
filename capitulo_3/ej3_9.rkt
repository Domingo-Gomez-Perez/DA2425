#lang racket

;Recursiva
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

;Iterativa
(define (factorial-iter n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;Show the environment structures created by evaluating `(factorial 6)`
;using each version of the `factorial` procedure.

(factorial 3)
;En la recursiva, al crearse un ambiente cada vez que se ejecuta la
;funcion, se crearan n ambientes, siendo n el numero del factorial a calcular.

;1o ITERACION
;ambiente global -> codigo
;ambiente factorial | codigo -> n = 3 | factorial

;2o ITERACION
;ambiente global -> codigo
;ambiente factorial 3 | codigo-> n = 3 | factorial
;ambiente factirial 2 | codigo -> n = 2 | factorial

;3o ITERACION
;ambiente global -> codigo
;ambiente factorial 3 | codigo -> n = 3 | factorial
;ambiente factirial 2 | codigo -> n = 2 | factorial
;ambiente factorial 1 | codigo -> n = 1

;4o ITERACION
;ambiente global -> codigo
;ambiente factorial 3 | codigo -> n = 3 | factorial
;ambiente factirial 2 | codigo -> n = 2 | factorial
;ambiente factorial 1 | codigo -> n = 1 | 1

;5o ITERACION
;ambiente global -> codigo
;ambiente factorial 3 | codigo -> n = 3 | factorial
;ambiente factirial 2 | codigo -> n = 2 | 2

;6o ITERACION
;ambiente global -> codigo
;ambiente factorial 3 | codigo -> n = 3 | 6

(factorial-iter 3)

;1o ITERACION
;ambiente global -> codigo
;ambiente factorial-iter | codigo -> n = 2 | factorial-iter
;factorial-iter | codigo -> product = 1, counter = 1, max-count = 3

;2o ITERACION
;ambiente global -> codigo
;ambiente factorial-iter | codigo -> n = 2 | factorial-iter
;factorial-iter | codigo -> product = 1, counter = 2, max-count = 3

;3o ITERACION
;ambiente global -> codigo
;ambiente factorial-iter | codigo -> n = 2 | factorial-iter
;factorial-iter | codigo -> product = 2, counter = 3, max-count = 3

;4o ITERACION
;ambiente global -> codigo
;ambiente factorial-iter | codigo -> n = 2 | factorial-iter
;factorial-iter | codigo -> product = 6, counter = 4, max-count = 3

;Acaba con result = 6






