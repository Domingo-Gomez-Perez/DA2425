#lang racket


#|
**Exercise 1.31:**

1. The `sum` procedure is only the simplest of a vast number of similar
abstractions that can be captured as higher-order procedures. Write an analogous
procedure called `product` that returns the product of the values of a
function at points over a given range.  Show how to define `factorial` in
terms of `product`.  Also use `product` to compute approximations to
`pi` using the formula

```
pi   2 * 4 * 4 * 6 * 6 * 8 ...
-- = -------------------------
 4   3 * 3 * 5 * 5 * 7 * 7 ...
```
|#

(define (next n)
  (+ 1 n))

(define (identity n) n)

;Versión recursiva

(define (product term a next b)  ;term es la función que se le aplica a "a" y a
                                 ;los siguientes valores hasta alacnazar el valor de b,
                                 ;next es el siguiente de a y b es el último número (límite)
  (if (> a b)
      1 
      (* (term a)
         (product term (next a) next b))))

(product identity 3 next 5)

;Función factorial en función de la función product
(define (factorial b)
  (product identity 1 next b))

(factorial 5)


#|
Aproximación a "pi", tendré que poner un número máximo de iteraciones para evaluarlo
teniendo en cuenta que según el ejemplo los valores del numerador se obtiene con el producto de
números pares y los del denominador con el producto de impares.
Busqué la fórmula correspondiente para saber de que fórmula se trataba y saber si seguía un patrón
para hacerlo en función del número de iteraciones y encontré que se trataba del producto
de Wallis, de tal forma que para conseguir una aproximación de pi, se realiza el productorio desde 1 hasta
el número de iteraciones indicado de ((4*n^2) / (4*n^2 -1)):


```
pi   4 * 4 * 4 * 6 * 6 * 8 ...
-- = -------------------------   
 2   3 * 3 * 5 * 5 * 7 * 7 ...
```



|#


(define (num a) (* 4(* a a)))
(define (dem a) (- (* 4(* a a)) 1))
(define (plus-2 a) (+ 2 a))

(define (pi-aprox n)
  (* 2(/ (product num 1 next n) (product dem 1 next n))))

(pi-aprox 2)

  




#|
2. If your `product` procedure generates a recursive process, write one that
generates an iterative process.  If it generates an iterative process, write
one that generates a recursive process.
|#

;Versión iterativa


(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
         result
        (iter (next a) (* (term a) result))))
    (iter a 1))

(product-iter identity 1 next 5)


