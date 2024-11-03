#lang racket


#|
Exercise 1.7: The good-enough? test used in computing square roots will not be very effective for finding
the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always
 performed with limited precision. This makes our test inadequate for very large numbers.
Explain these statements, with examples showing how the test fails for small and large numbers.
 An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration
to the next and to stop when the change is a very small fraction of the guess.
Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

|#


;Version ejercicio 1.6

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))



(define (good-enough? guess x)
  (< (abs (- x (* guess guess))) 0.001))


(define(improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (* 0.5 (+ x y)))


(define (sqrt-iter guess x)
  (if(good-enough? guess x)                   
          guess                               
          (sqrt-iter (improve guess x) x)))

#|Version ej 1.7: una posible mejora para el cálculo de la ráiz cuadrada de un número según una tolerancia
sería comparar una tolerancia relativa en vez de la absoluta con 0.001 usada en el ej anterior para que se vaya evaluando
según el número de iteraciones si ese valor obtenido es el adecuado, para ello, en vez de evaluar la tolerancia (absoluta)
como |x - (guess * guess) | y ver si es suficientemente bueno (es decir, si se aproxima a la raíz cuadrada de un número x)
comparándolo con una tolerancia. Por lo tanto, lo que haré será
obtener una tolerancia relativa con el siguiente cálculo |(x - (guess * guess) |  / |x|; y este valor se compara con 0.001 para ver si
en cada iteración ese valor que es proporcional al valor anterior, es lo suficientemente bueno: 
|#


(define (good-enough2? guess x)
  (< (/(abs (- x (* guess guess))) (abs x)) 0.001))


(define(improve2 guess x)
  (average guess (/ x guess)))

(define (average2 x y)
  (* 0.5 (+ x y)))


(define (sqrt-iter2 guess x)
  (if(good-enough2? guess x)                   
          guess                               
          (sqrt-iter2 (improve2 guess x) x)))




(display "Raiz cuadrada de 0.00055")
(newline)
(sqrt-iter 0.007 0.000055)
(newline)

(display "Raiz cuadrada (tolerancia relativa de 0.00055")
(newline)
(sqrt-iter2 0.007 0.000055)
(newline)


(display "Raiz cuadrada de 50000000000")
(newline)
(sqrt-iter 223606 50000000000)
(newline)

(display "Raiz cuadrada (tolerancia relativa de 50000000000")
(newline)
(sqrt-iter2 223606 50000000000)

#|A la vista de estos ejemplos se ve que con el cálculo de tolerancia relativa se obtiene una mejor aproximación
de la raíz cuadrada de una número pequeño o grande, y esto se puede deber a cómo trabaja los computadores con los números binarios,
ya que de esta forma la aproximación del valor de la raíz cuadrada de un número aumenta proporcionalmente con la iteración|#