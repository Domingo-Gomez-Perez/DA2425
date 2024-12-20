#lang racket

(define (make-queue)
  (let ((front-ptr '())  
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (enqueue item)  
      (let ((new-pair (mcons item '())))
        (if (empty-queue?)             
            (begin                     
              (set! front-ptr new-pair)
              (set! rear-ptr new-pair))
            (begin                    
              (set-mcdr! rear-ptr new-pair)
              (set! rear-ptr new-pair)))))
    (define (dequeue)
      (if (empty-queue?)
          (error "Queue is empty")
          (let ((item (mcar front-ptr)))
            (set! front-ptr (mcdr front-ptr))  
            (if (null? front-ptr)             
                (set! rear-ptr '())          
                (void))                      
            item)))
    (define (front) 
      (if (empty-queue?)
          (error "Queue is empty")
          (mcar front-ptr)))
    
    ;Dispatch
    (define (dispatch message)
      (cond ((eq? message 'empty?) empty-queue?)
            ((eq? message 'enqueue) enqueue)
            ((eq? message 'dequeue) dequeue)
            ((eq? message 'front) front)))
    
    dispatch))

;Ejemplo de uso
(define q (make-queue))
((q 'enqueue) 10)
((q 'enqueue) 20)
((q 'enqueue) 30)
(displayln ((q 'dequeue)))  ; 10
(displayln ((q 'front)))    ; 20
(displayln ((q 'dequeue)))  ; 20
(displayln ((q 'dequeue)))  ; 30
(displayln ((q 'empty?)))   ; #t