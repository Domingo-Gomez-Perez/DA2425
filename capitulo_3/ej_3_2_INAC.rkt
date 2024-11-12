#lang racket

(define (make-monitored x)
  (define counter 0)
  (define (mf y)
    (begin
      (cond
        ((eq? 'how-many-calls? y) counter)
        ((eq? 'reset-count y)
         (set! counter 0))
        (else (
               (set! counter (+ counter 1))
               (x y)
               )
              )
        )
      )
    )
  mf
  )


(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)
1