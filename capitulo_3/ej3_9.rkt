#lang racket
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

;and an iterative version

```
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
```

;Show the environment structures created by evaluating `(factorial 6)`
;using each version of the `factorial` procedure.

;En la recursiva, al crearse un ambiente cada vez que se ejecuta la funcion, se crearan n ambientes, siendo n el numero del factorial a calcular.
;RESULTADO (factorial 3)

;1º ITERACION
;ambiente global -> factorial 3
;ambiente factorial -> n = 3 factorial(2)

;2º ITERACION
;ambiente global -> factorial 3
;ambiente factorial -> n = 6 factorial(5)
