#lang racket

(define (accumulate combiner null-value term a b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (add1 a) b))))

(define (accumulate-iter combiner null-value term a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (add1 a) (combiner (term a) result))))
  (iter a null-value))

;; length usando accumulate
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 (lambda (x) x) 0 (sub1 (length sequence))))

;; append usando accumulate
(define (appended seq1 seq2)
  (accumulate cons seq2 (lambda (x) x) 0 (sub1 (length seq1))))

;; map usando accumulate
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) empty (lambda (x) x) 0 (sub1 (length sequence))))


