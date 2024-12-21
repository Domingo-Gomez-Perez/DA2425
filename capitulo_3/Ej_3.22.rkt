#lang racket

(define (make-queue)
  (let ((front-ptr '())  
        (rear-ptr '()))   
    (define (enqueue x)
      (set! rear-ptr (cons x '()))  
      (if (null? front-ptr)         
          (set! front-ptr rear-ptr)
          null)
      )

    (define (dequeue)
      (if (null? front-ptr)         
          'empty
          (let ((value (car front-ptr)))  
            (set! front-ptr (cdr front-ptr))  
            value)))  

    (define (front)
      (if (null? front-ptr)         
          'empty
          (car front-ptr)))         

    (define (is-empty?)
      (null? front-ptr))  

    (define (dispatch m)
      (cond ((eq? m 'enqueue) enqueue)
            ((eq? m 'dequeue) dequeue)
            ((eq? m 'front) front)
            ((eq? m 'is-empty?) is-empty?)
            (else 'unknown-operation)))

    dispatch))

(define lista (make-queue))
((lista 'enqueue) 1)
((lista 'enqueue) 2)
((lista 'enqueue) 3)
((lista 'front))


