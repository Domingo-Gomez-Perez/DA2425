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

;Misma explicacion con el metodo de sustitucion:
;(* 6 (factorial (- 6 1)))
;(* 6 (* 5 (factorial (- 5 1))))
;(* 6 (* 5 (* 4 (factorial (- 4 1)))))
;(* 6 (* 5 (* 4 (* 3 (factorial (- 3 1))))))
;(* 6 (* 5 (* 4 (* 3 (* 2 (factorial (- 2 1)))))))
;(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
;(* 6 (* 5 (* 4 (* 3 2))))
;(* 6 (* 5 (* 4 6)))
;(* 6 (* 5 24))
;(* 6 120)
;720

;La complejidad temporal es 0(n) y la espacial, al tener que guardar el 6, 5, 4, 3, 2, 1 es 0(n)


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