#lang racket

; Exercise 3.22

; Instead of representing a queue as a pair of pointers, we can
; build a queue as a procedure with local state. The local state
; will consist of pointers to the beginning and the end of an
; ordinary list. Thus, the `make-queue` procedure will have the form

; (define (make-queue)
;   (let ((front-ptr ...)
;         (rear-ptr ...))
;     ⟨ definitions of internal procedures ⟩
;     (define (dispatch m) ...)
;     dispatch))

; Complete the definition of `make-queue` and provide implementations
; of the queue operations using this representation.



(define (make-queue)
  (let ( (front-ptr '()) (rear-ptr '()) )

    (define (set-front-ptr! item)
      (set! front-ptr item))
    

    (define (set-rear-ptr! item)
      (set! rear-ptr item))


    (define (empty-queue?)
      (null? front-ptr))


    (define (front-queue)
      (if (empty-queue?)
          (error "Cola vacia")
          (mcar front-ptr)))


    (define (insert-queue! item)
      (let ((new-pair (mcons item '())))
        (if (empty-queue?)
          (begin (set-front-ptr! new-pair) (set-rear-ptr! new-pair) front-ptr)
          (begin (set-mcdr! rear-ptr new-pair) (set-rear-ptr! new-pair) front-ptr))))


    (define (delete-queue!)
      (if (empty-queue?)
          (error "Cola vacia")
          (begin (set-front-ptr! (mcdr front-ptr)) front-ptr)))


    (define (dispatch m)
      (cond ((eq? m 'front-ptr) front-ptr)
            ((eq? m 'rear-ptr) rear-ptr)
            ((eq? m 'set-front-ptr!) set-front-ptr!)
            ((eq? m 'set-rear-ptr!) set-rear-ptr!)
            ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            (else (error "Operacion desconocida" m))))

    dispatch))



; Initial queue
(define queue (make-queue))
((queue 'empty-queue?))       ; #t

; Insert (a, b, c)
((queue 'insert-queue!) 'a)   ; (mcons 'a '())
((queue 'insert-queue!) 'b)   ; (mcons 'a (mcons 'b '()))
((queue 'insert-queue!) 'c)   ; (mcons 'a (mcons 'b (mcons 'c '())))
((queue 'empty-queue?))       ; #f

; Observe the head
((queue 'front-queue))        ; 'a

; Observe the pointers
(queue 'front-ptr)            ; (mcons 'a (mcons 'b (mcons 'c '())))
(queue 'rear-ptr)             ; (mcons 'c '())

; Remove elements
((queue 'delete-queue!))      ; (mcons 'b (mcons 'c '()))
((queue 'delete-queue!))      ; (mcons 'c '())
((queue 'delete-queue!))      ; '()
