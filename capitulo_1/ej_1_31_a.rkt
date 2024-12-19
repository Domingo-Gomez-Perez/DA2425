#lang racket

(define (prod term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (inc x) (+ x 1))

(prod * 1 inc 4)


(define (factorial n)
  (prod * 1 inc n)) ;El parámetro term aquí da igual

(factorial 4)

;El atributo max_producto_serie ha de ser par
(define (aprox_pi max_producto_serie)
  (define (inc2 x) (+ x 2))
  (define (square x) (* x x))
  (* 4 (/ (* 2 (prod square 4 inc2 max_producto_serie)) (* max_producto_serie (prod square 3 inc2 (- max_producto_serie 1))))))
  ;(* 4 (/ (* 2 (square (prod * 4 inc2 max_producto_serie))) (* max_producto_serie (square (prod * 3 inc2 (- max_producto_serie 1)))))))
  ;Aunque esta implementación sea más larga, es más eficiente, porque solo se aplica la función square dos veces, y no (b-a)/next veces

(aprox_pi 204)