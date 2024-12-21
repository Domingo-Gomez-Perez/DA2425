#lang racket
; Implementación de la cola
(define (make-queue)
  (let ((front-ptr null)
        (rear-ptr null))
    ; Enqueue: Agrega un elemento al final de la cola
    (define (enqueue item)
      (let ((new-pair (mcons item null)))
        (if (null? front-ptr)
            (set! front-ptr new-pair)
            (set-mcdr! rear-ptr new-pair))
        (set! rear-ptr new-pair)))
    ; Dequeue: Remueve y devuelve el elemento del frente
    (define (dequeue)
      (if (null? front-ptr)
          (error "Queue is empty")
          (let ((item (mcar front-ptr)))
            (set! front-ptr (mcdr front-ptr))
            item)))
    ; Verifica si la cola está vacía
    (define (is-empty?)
      (null? front-ptr))
    ; Mostrar la cola
    (define (print-queue)
      (define (print-elements ptr)
        (if (null? ptr)
            (newline) ; Fin de la impresión
            (begin
              (display (mcar ptr)) ; Mostrar el elemento actual
              (display " ") ; Separador
              (print-elements (mcdr ptr))))) ; Recursión al siguiente par
      (if (null? front-ptr)
          (display "Queue is empty\n") ; Mensaje si está vacía
          (print-elements front-ptr)))
    ; Despachador para seleccionar las operaciones
    (define (dispatch m)
      (cond ((eq? m 'enqueue) enqueue)
            ((eq? m 'dequeue) dequeue)
            ((eq? m 'is-empty?) is-empty?)
            ((eq? m 'print) print-queue)
            (else (error "Unknown request: MAKE-QUEUE" m))))
    dispatch))


; Ejemplos:
(define q (make-queue))

; Agregar elementos
((q 'enqueue) 'a)
((q 'enqueue) 'b)
((q 'enqueue) 'c)
((q 'print))

; Remover elementos
(display ((q 'dequeue))) ; Deberia devolver a
(newline)
((q 'print))
(display ((q 'dequeue))) ; Deberia devolver b
(newline)

; Verificar si la cola está vacía
(display ((q 'is-empty?))) ; Deberia devolver #f (no está vacía)
(newline)
