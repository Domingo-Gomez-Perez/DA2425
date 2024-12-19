#lang racket
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(define (pi-approx n)
  (* 2
     (product (lambda (k) (/ (* (* 2 k) (* 2 k))
                             (* (- (* 2 k) 1) (+ (* 2 k) 1))))
              1
              (lambda (k) (+ k 1))
              n)))

;He usado la formula de Walls que debería ser equivalente y me ha sido más facil de implementar que la del libro



(product (lambda (x) x) 1 (lambda (x) (+ x 1)) 5)
(factorial 5)
(pi-approx 5)
(pi-approx 100)


(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial-iter n)
  (product-iter (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(define (pi-approx-iter n)
  (* 2
     (product-iter (lambda (k) (/ (* (* 2 k) (* 2 k))
                             (* (- (* 2 k) 1) (+ (* 2 k) 1))))
              1
              (lambda (k) (+ k 1))
              n)))

(product-iter (lambda (x) x) 1 (lambda (x) (+ x 1)) 5)
(factorial-iter 5)
(pi-approx-iter 5)
(pi-approx-iter 100)