#lang racket
;Ejercicio 3.22

(define (make-queue)
  (let ((front-ptr null) 
        (rear-ptr null))
    
    (define (empty-queue?) 
      (null? front-ptr))

    (define (enqueue item)
      (let ((new-pair (mcons item null))) 
        (if (empty-queue?)
            (begin 
              (set! front-ptr new-pair)
              (set! rear-ptr new-pair))
            (begin
              (set-mcdr! rear-ptr new-pair) 
              (set! rear-ptr new-pair))))) 

    (define (dequeue)
      (if (empty-queue?)
          (error "Cola vacía")
          (let ((item (mcar front-ptr)))
            (set! front-ptr (mcdr front-ptr))
            (when (null? front-ptr) 
              (set! rear-ptr null))
            item))) 

    (define (front)
      (if (empty-queue?)
          (error "Cola vacía")
          (mcar front-ptr))) 

    
    (define (dispatch message)
      (cond ((eq? message 'empty?) empty-queue?)
            ((eq? message 'enqueue) enqueue)
            ((eq? message 'dequeue) dequeue)
            ((eq? message 'front) front)
            (else null)))
    
    dispatch))



(define n (make-queue))

((n 'enqueue) 'a)
((n 'enqueue) 'b)
((n 'enqueue) 'c)

((n 'front));a

((n 'dequeue));a 
((n 'dequeue));b

((n 'empty?));#f

((n 'dequeue));c

((n 'empty?));#t

((n 'dequeue)) ;error