#lang racket
(require racket/list)

; **Exercise 3.22:** Instead of representing a queue
; as a pair of pointers, we can build a queue as a procedure with local state.
; The local state will consist of pointers to the beginning and the end of an
; ordinary list.  Thus, the `make-queue` procedure will have the form

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))
    (define (insert-queue item)
      (let ((new-pair (list item)))
        (if (empty-queue?)
            (begin
              (set! front-ptr new-pair)
              (set! rear-ptr new-pair))
            (begin
              (set-cdr! rear-ptr new-pair)
              (set! rear-ptr (cdr rear-ptr))))))
    (define (delete-queue)
      (if (empty-queue?)
          (error "DELETE called with an empty queue")
          (set! front-ptr (cdr front-ptr))))
    (define (dispatch m)
      (cond ((eq? m 'empty?) empty-queue?)
            ((eq? m 'front) front-queue)
            ((eq? m 'insert) insert-queue)
            ((eq? m 'delete) delete-queue)
            (else (error "Unknown operation -- MAKE-QUEUE" m))))
    dispatch))

(define (set-cdr! pair new-cdr)
  (if (pair? pair)
      (set-cdr! pair new-cdr)
      (error "set-cdr!: not a pair" pair)))

; Complete the definition of `make-queue` and provide implementations of the
; queue operations using this representation.

;
; Let's test the implementation
; 
(define q (make-queue))
((q 'empty?)) ; #t
((q 'insert) 1)
((q 'empty?)) ; #f
((q 'front))  ; 1
((q 'insert) 2)
((q 'front))  ; 1
((q 'delete))
((q 'front))  ; 2
((q 'delete))
((q 'empty?)) ; #t
