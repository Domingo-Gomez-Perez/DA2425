#lang racket
;Exercise 1.30: The following sum procedure generates a linear recursion:

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

;The procedure can be rewritten so that the sum is performed iteratively. Show how to do this by filling in the missing expressions in the following definition:

(define (sum2 term a next b)
  (define (bucle a total)
    (if (> a b)
        total  ; Si a > b devolvemos el resultado acumulado
        (bucle (next a) (+ total (term a)))))  
  (bucle a 0))  ; Llamada inicial


(define (repetir x) x)
(define (next x) (+ x 1))

(sum repetir 1 next 5)
(sum2 repetir 1 next 5)
;Comprobamos que funciona