#lang racket
;Ejercicio 2.33

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (factorial n)
  (define (rango n)
    (if (= n 1)
        (list 1)
        (append (list n) (rango (- n 1)))))
  (accumulate * 1(rango n)))

;map
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              null
              sequence))


(map (lambda (x) (* x x)) '(1 2 3 4)) 

;append
(define (appended seq1 seq2)
  (accumulate cons seq2 seq1))

(append (list 1 2 3) (list 4 5))

;length
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(length (list 4 5 6))



