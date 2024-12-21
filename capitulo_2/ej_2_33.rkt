#lang racket
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))



(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append (list 1 2 3) (list 4 5 6))

(define (length sequence)
  (accumulate (lambda (nothing returned) (+ 1 returned))
              0
              sequence))

(length (list 1 2 3 4 5 1 1 1 5)) ;-> 9 elementos

(define (bruh x y)
  ((cond ((null? x)  (null))
         ((not (pair? x))  (pa x))
         (else  (cons (map pa x) y)))))

(define (map p sequence)
 (accumulate (lambda (x y) (cons (p x) y))
              null
              sequence))

(define (pa x) (* x 2))

(map pa (list 1 2 3 4))

;bucle for: (devuelve el array range (como el de Python))

(define (for init limit inc)
  (define (range cont)
    (if (= cont limit)
        null
        (cons cont (range (+ cont inc)))))
  (accumulate cons
              null
              (range init)))

(for 0 9 1)

