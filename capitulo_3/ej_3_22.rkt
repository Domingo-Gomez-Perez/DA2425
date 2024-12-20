#lang racket
(define (make-queue)
  (let ((front-ptr null) 
        (rear-ptr null))

    ; Función para verificar si la cola está vacía.
    (define (empty-queue?)
      (null? front-ptr))

    ; Función para insertar un nuevo elemento en la cola.
    (define (insert-queue! item)
      (let ((new-pair (mcons item '())))
        (cond ((empty-queue?)
          (set-front-ptr! new-pair)
          (set-rear-ptr! new-pair))
          (else (set-mcdr! rear-ptr new-pair)
          (set-rear-ptr! new-pair)))))

    ; Función para obtener el primer elemento de la cola.
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (mcar front-ptr)))

    ; Función para eliminar el primer elemento de la cola.
    (define (delete-queue!)
      (if (empty-queue?)
          (error "DELETE! called with an empty queue")
          (set! front-ptr (mcdr front-ptr)))) 

    (define (set-front-ptr! new-front)
      (set! front-ptr new-front))

    (define (set-rear-ptr! new-rear)
      (set! rear-ptr new-rear))
    
    ; Función de dispatch para manejar las operaciones de la cola.
    (define (dispatch m)
      (cond
        [(eq? m 'empty-queue?) empty-queue?]
        [(eq? m 'insert-queue!) insert-queue!]
        [(eq? m 'front-queue) front-queue]
        [(eq? m 'delete-queue!) delete-queue!]
        [else (error "Unknown operation -- QUEUE" m)]))

    dispatch))


(define q (make-queue))

((q 'insert-queue!) 'a) ; Inserta 1 en la cola
((q 'insert-queue!) 'b) ; Inserta 2 en la cola
((q 'front-queue)) ; Muestra el primer elemento de la cola (1)
((q 'delete-queue!)) ; Elimina el primer elemento de la cola (1)
((q 'front-queue)) ; Muestra el nuevo primer elemento (2)