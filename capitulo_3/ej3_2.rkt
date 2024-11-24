#lang racket
(define (make-monitored f)
  (define counter 0)
  (define (mf input)
    (cond ((eq? input 'how-many-calls?) counter)
          ((eq? input 'reset-count) (set! counter 0))
          (else (begin
                  (set! counter (+ counter 1))
                  (f input)))))
  mf)

; Comprobar
(define s (make-monitored sqrt))
(s 100) ; -> 10
(s 'how-many-calls?) ; -> 1
(s 49) ; -> 7
(s 25) ; -> 5
(s 'how-many-calls?) ; -> 3
(s 'reset-count)
(s 'how-many-calls?) ; -> 0
