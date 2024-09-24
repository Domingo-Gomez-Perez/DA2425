#lang racket
;Ejercicio 1.31
(define (inc x) (+ x 1))


;Analogo a sum pero con multiplicacion en vez de suma
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(product * 2 inc 12)

;Factorial

(define (factorial x)
  (product * 1 inc x))

(factorial 6)


;Aproximacion de pi
(define (square x) (* x x))
(define (inc2 x) (+ x 2))
(define (pred x) (- x 1))
(define (pi-aprox n)
  (* 4
     (/
      (* 2 (product square 4 inc2 n))
      (* n (product square 3 inc2 (pred n))))))

(pi-aprox 24)

;Product recursivo

(define (productr term a next b)
  (if (> a b)
      1
      (* (term a)
         (productr term (next a) next b))))


(productr * 2 inc 12)
  