#lang racket
(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt-iter b n)
  (define (iter b n result) ; b es la base, n el exponente y result el resultado acumulado
    (cond
      ((= n 0) result)  ; Caso base: if n = 0, return result
      ((even? n) (iter (* b b) (/ n 2) result))  ; Si n es par, la base se convierte en su cuadrado y se divide n a la mitad
      (else (iter b (- n 1) (* result b)))))  ; Si n es impar, se multiplica result por la base y se decrementa el exponente
  (iter b n 1))  ; Caso incial result = 1

(fast-expt 3 4)
(fast-expt-iter 3 4)
