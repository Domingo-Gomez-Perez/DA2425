#lang racket

(define contador 0)

(define (make-monitored func)
  (define (how-many-calls?)
         contador)
  (define (reset-count)
         (begin
           (set! contador 0)))
  (define (hacerfunc valor)
    (begin
           (set! contador (+ contador 1))
  (func valor)))
  
  (define (dispatch m)
          (cond ((eq? m 'how-many-calls?) how-many-calls?)
                ((eq? m 'reset-count) reset-count)
                ((not (eq? m 'how-many-calls?)) hacerfunc)
                ((not (eq? m 'reset-count)) hacerfunc)))
  
  dispatch)

(define s (make-monitored sqrt))




((s 'how-many-calls?))
((s 'pdnskfn) 100)
((s 'pdnskfn) )
((s 'how-many-calls?))
