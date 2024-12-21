#lang racket
(define (make-monitored funct)
  (let ((cont 0))
    (lambda (x)
      (cond ((eq? x 'how-many-calls?) cont)
            ((eq? x 'reset-count) (set! cont 0))
            (else (set! cont (+ cont 1))
                  (funct x))))))

(define s (make-monitored sqrt))

(s 100)
10

(s 'how-many-calls?)
1

(s 'reset-count)
(s 'how-many-calls?)
0