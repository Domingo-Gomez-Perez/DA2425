#lang racket

#|
**Exercise 1.30:** The following `sum` procedure generates a linear recursion:

```
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
```

The procedure can be rewritten so that the sum is performed
iteratively.  Show how to do this by filling in the missing
expressions in the following definition:

```
(define (sum term a next b)
  (define (iter a result)
    (if ⟨??⟩
        ⟨??⟩
        (iter ⟨??⟩ ⟨??⟩)))
  (iter ⟨??⟩ ⟨??⟩))
```
|#


#|

(define (sum2 term a next b)  ;term es la función que se le aplica a "a", next es el siguiente de a y b es el último número a sumar (límite)
  (if (> a b)
      0
      (+ (term a)
         (sum2 term (next a) next b))))
(sum2 identity 7 next 24)

|#


#|
Mi solución:
|#
(define (next n)
  (+ 1 n))


;Versión iterativa a completar
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        
        (iter (next a) (+ (term a) result))))
    (iter a 0))

(define (square n) (* n n))
(sum square 1 next 5)


;Versión iterativa versión 2
(define (iter2 term a result b)  ;tiene más argumentos ("term" y "b)
    (if (> a b)
        result
        
        (iter2 term (next a) (+ (term a)result) b)))

(define (sum4 term a next  b) 
    (iter2 term a 0 b))

(sum4 square 1 next 5)

#|
Esta función es equivalente a :


(define (sum3 term a next  b) 
    (iter2 term a 0 b))

(define (iter2 term a result b)  ;tiene más argumentos ("term" y "b)
    (if (> a b)
        result
        
        (iter2 term (next a) (+ (term a)result b)))))


(sum3 identity 7 next 24)

|#



