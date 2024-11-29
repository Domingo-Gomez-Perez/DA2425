#lang racket

(define (make-monitored f)
  (let ((contador 0))
    (define (mf x)
      (cond ((eq? x 'how-many-calls?) (displayln contador))
            ((eq? x 'reset-count) (set! contador 0))
            (else (begin (f x)
                         (set! contador (+ contador 1))
                         (f x)
                         ))
            ))mf))

(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)

(s 9)

(s 'how-many-calls?)

(s 20)

(s 'how-many-calls?)

(s 'reset-count)

(s 'how-many-calls?)

