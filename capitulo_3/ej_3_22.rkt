#lang racket


#|

**Exercise 3.22:** Instead of representing a queue
as a pair of pointers, we can build a queue as a procedure with local state.
The local state will consist of pointers to the beginning and the end of an
ordinary list.  Thus, the `make-queue` procedure will have the form

```
(define (make-queue)
  (let ((front-ptr ... )
        (rear-ptr ... ))
    ⟨ definitions of internal procedures ⟩
    (define (dispatch m) ...)
    dispatch))
```

Complete the definition of `make-queue` and provide implementations of the
queue operations using this representation.
|#



(define (make-queue)
  (let ((front-ptr '())  ; Puntero al inicio de la cola
        (rear-ptr '()))  ; Puntero al final de la cola

    ; Verifica si la cola está vacía
    (define (empty?)
      (null? front-ptr))

    ; Agrega un elemento al final de la cola
    (define (enqueue item)
      (let ((new-pair (mcons item '())))
        (if (empty?)                   ; Si la cola está vacía
            (begin
              (set! front-ptr new-pair) ; Ambos punteros apuntan al nuevo par
              (set! rear-ptr new-pair))
            (begin                      ; Si no está vacía
              (set-mcdr! rear-ptr new-pair) ; Conecta el nuevo par al final
              (set! rear-ptr new-pair)))))  ; Actualiza el puntero trasero

    ; Quita un elemento del inicio de la cola y lo devuelve
    (define (dequeue)
      (if (empty?)
          (error "La cola está vacía -- DEQUEUE")
          (let ((front-item (mcar front-ptr)))
            (set! front-ptr (mcdr front-ptr)) ; Avanza el puntero frontal
            front-item)))

    ; Devuelve el valor al inicio de la cola sin modificarla
    (define (front)
      (if (empty?)
          (error "La cola está vacía -- FRONT")
          (mcar front-ptr)))

    ; Dispatch para seleccionar operaciones
    (define (dispatch m)
      (cond ((eq? m 'empty?) empty?)
            ((eq? m 'enqueue) enqueue)
            ((eq? m 'dequeue) dequeue)
            ((eq? m 'front) front)
            (else (error "Operación desconocida -- MAKE-QUEUE" m))))

    dispatch))  



;Ejemplo de uso

; Crear una cola
(define queue (make-queue))

; Obtener las operaciones disponibles
(define empty? (queue 'empty?))
(define enqueue (queue 'enqueue))
(define dequeue (queue 'dequeue))
(define front (queue 'front))

; Verificar si la cola está vacía
(display (empty?)) ; Output: #t
(newline)

; Agregar elementos a la cola
(enqueue 10)
(enqueue 20)
(enqueue 30)

; Verificar si la cola está vacía después de agregar elementos
(display (empty?)) ; Output: #f
(newline)

; Ver el elemento al frente de la cola
(display (front)) ; Output: 10
(newline)

; Eliminar un elemento de la cola
(display (dequeue)) ; Output: 10
(newline)

; Ver el siguiente elemento al frente
(display (front)) ; Output: 20
(newline)

; Eliminar más elementos
(display (dequeue)) ; Output: 20
(newline)
(display (dequeue)) ; Output: 30
(newline)

; Intentar quitar un elemento de una cola vacía (debería dar un error)
;(display (dequeue)) ; Error: La cola está vacía -- DEQUEUE


