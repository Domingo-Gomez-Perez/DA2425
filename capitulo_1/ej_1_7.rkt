#lang racket
;Exercise 1.7: The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers.
;Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers.
;Explain these statements, with examples showing how the test fails for small and large numbers.
;An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess.
;Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

;El principal problema de la funcion "good-enough?" es que tiene un valor fijo para aceptar o no el "guess", este valor fijo es "0.001" sin importar el valor de "x"
;Esto puede causar errores en casos de números muy grandes o muy pequeños, por ejemplo usando números muy grandes podriamos tener un "guess" adecuado debido al orden del número grande,
;pero que el valor fijo no aceptara, llevando asi a una gran cantidad de iteraciones innecesarias al ser el "guess" suficientemente correcto

;El umbral fijo de 0.001 es demasiado grande comparado con números pequeños. Esto puede hacer que el algoritmo termine antes de lo previsto, devolviendo resultados inexactos.

;Para mejorar la funcion tendremos en cuenta si ha mejorado o no el guess respecto al anterior.
(define (good-enough? old-guess new-guess)
  (< (/ (abs (- new-guess old-guess)) new-guess) 0.0001))  ; Comparar el cambio relativo

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))

(define (sqrt-iter old-guess guess x)
  (if (good-enough? old-guess guess)
      guess
      (sqrt-iter guess (improve guess x) x)))

(define iniciofijo 0.0)
(sqrt-iter iniciofijo 2.0 81)
