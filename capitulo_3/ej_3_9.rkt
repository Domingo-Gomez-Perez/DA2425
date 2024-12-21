#lang racket

; recursivo
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
;Cuando se ejecuta el metodo factorial se crea un nuevo ambiente que esa enlazado al ambiente global y se da un valor al argumento n, en este caso 6
;Este ambiente, crea otro asignando al argumento n valor 5, que a su vez genera otro ambiente que asignadno al argumento n valor 4. Esto sucede hasta
;llegar al ambiente con valor n=1 que devuelve al ambiente anterior 1, este a su vez devuelve el valor 2 y asi sucesivamente hasta que se llega al primer
;ambiente que tiene la multiplicacion de los anteriores y devuelve 120 * 6 = 720



; iterativo
(define (factorial1 n)
  (fact-iter 1 1 n))

(define (fact-iter product 
                   counter 
                   max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; Cuando se ejecuta el método factorial1, se crea un ambiente inicial para la llamada (fact-iter 1 1 6). Este ambiente tiene los valores: product = 1,
; counter = 1 y max-count = 6
; La primera vez, dado que counter (1) es menor o igual que max-count (6), la función realiza una llamada recursiva a (fact-iter (* 1 1) (+ 1 1) 6),
; lo que equivale a (fact-iter 1 2 6). Este nuevo ambiente tiene los valores: product = 1, counter = 2 y max-count = 6
; Luego, la función realiza otra llamada recursiva a (fact-iter (* 2 1) (+ 2 1) 6), que equivale a (fact-iter 2 3 6). Esto sigue sucediendo hasta que el
; valor de counter llega a 7 (cuando counter > max-count), momento en el que se retorna el valor de product (720).