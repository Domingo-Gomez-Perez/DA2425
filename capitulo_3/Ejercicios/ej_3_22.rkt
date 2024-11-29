#lang racket
(define (make-queue)
  (let ((front-ptr '()) ; Puntero al frente de la cola
        (rear-ptr '())) ; Puntero al final de la cola

    ; Procedimientos auxiliares para trabajar con la cola
    (define (is-empty?)
      (null? front-ptr))
    
    (define (enqueue item) ; Añade un elemento al final de la cola
      (let ((new-node (mcons item '())))
        (if (is-empty?)
            (begin
              (set! front-ptr new-node)
              (set! rear-ptr new-node))
            (begin
              (set-mcdr! rear-ptr new-node)
              (set! rear-ptr new-node)))))

    (define (dequeue) ; Elimina y devuelve el elemento al frente de la cola
      (if (is-empty?)
          (error "La cola está vacía -- DEQUEUE")
          (let ((item (mcar front-ptr)))
            (set! front-ptr (mcdr front-ptr))
            (if (null? front-ptr)
                (set! rear-ptr '())
                'done)
            item)))

    (define (front) ; Devuelve el elemento al frente sin eliminarlo
      (if (is-empty?)
          (error "La cola está vacía -- FRONT")
          (mcar front-ptr)))

    (define (rear) ; Devuelve el elemento al final sin eliminarlo
      (if (is-empty?)
          (error "La cola está vacía -- REAR")
          (mcar rear-ptr)))

    (define (dispatch m) ; Mecanismo de "message-passing" para seleccionar operaciones
      (cond ((eq? m 'empty?) is-empty?)
            ((eq? m 'enqueue) enqueue)
            ((eq? m 'dequeue) dequeue)
            ((eq? m 'front) front)
            ((eq? m 'rear) rear)
            (else (error "Operación desconocida -- MAKE-QUEUE" m))))

    dispatch))

(define q (make-queue))

;Encolar elementos
((q 'enqueue) 1)
((q 'enqueue) 2)
((q 'enqueue) 3)

;Desencolar elementos
(display ((q 'dequeue))) ; Salida: 1
(newline)

;Consultar el frente y el final de la cola
(display ((q 'front))) ; Salida: 2
(newline)
(display ((q 'rear))) ; Salida: 3
(newline)

;Verificar si la cola está vacía
(display ((q 'empty?))) ; Salida: #f
