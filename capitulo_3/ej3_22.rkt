#lang racket
(define (make-queue)
  (let ((front-ptr null)
        (rear-ptr null))

    ; Setters
    (define (set-front-ptr! item)
      (set! front-ptr item))
    
    (define (set-rear-ptr! item)
      (set! rear-ptr item))

    ; Procedimientos internos
    (define (empty-queue?)
      (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT: la cola está vacía")
          (mcar front-ptr)))
    
    (define (insert-queue! item)
      (let ((new-pair (mcons item null)))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               front-ptr)
              (else (set-mcdr! rear-ptr new-pair)
                    (set-rear-ptr! new-pair)
                    front-ptr))))
    
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE!: la cola está vacía"))
            (else (set-front-ptr! (mcdr front-ptr)) front-ptr)))

    ; Dispatch
    (define (dispatch m)
      (cond ((eq? m 'front-ptr) front-ptr)
            ((eq? m 'rear-ptr) rear-ptr)
            ((eq? m 'set-front-ptr!) set-front-ptr!)
            ((eq? m 'set-rear-ptr!) set-rear-ptr!)
            ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            (else null)))
    dispatch))

;; Comprobamos
; Cola inicial
(define a (make-queue))
(a 'front-ptr)
(a 'rear-ptr)
((a 'empty-queue?))

; Insertamos (a, b, c, d)
((a 'insert-queue!) 'a)
((a 'insert-queue!) 'b)
((a 'insert-queue!) 'c)
((a 'insert-queue!) 'd)
((a 'empty-queue?))

; Probamos la cabeza de la cola
((a 'front-queue))

; Probamos los punteros de estado de la cola
(a 'front-ptr)
(a 'rear-ptr)

; Extraemos todos los elementos de la cola
((a 'delete-queue!))
((a 'delete-queue!))
((a 'delete-queue!))
((a 'delete-queue!))

