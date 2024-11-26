#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.22: Instead of representing a queue as a pair of pointers, we can build a queue as a procedure
 with local state. The local state will consist of pointers to the beginning and the end of an ordinary list.
  Thus, the make-queue procedure will have the form:

(define (make-queue)
  (let ((front-ptr ...)
        (rear-ptr ... ))
    ⟨ definitions of internal procedures ⟩
    (define (dispatch m) ...)
    dispatch))

Complete the definition of make-queue and provide implementations of the queue operations using this representation.
|#

; En vez de como defines sin mas, pide que hagamos lo de la cuenta del banco. Poder crear
; una cuenta, depositar, retirar, consultar el saldo y cerrar la cuenta. pero con una cola.
; asi que solo hay que seguir el esquema pero con estos procedimientos.

(define (make-queue)
  (let ([front-ptr '()] ; Inicializa el puntero delantero como una lista vacía.
        [rear-ptr '()]) ; Inicializa el puntero trasero como una lista vacía.

    ;; Función para verificar si la cola está vacía.
    (define (empty-queue?)
      (null? front-ptr)) ; Una cola está vacía si el puntero delantero es vacío.

    ;; Función para insertar un nuevo elemento en la cola.
    (define (insert-queue! item)
      ;; Creamos un nuevo par que contiene el item como car y '() como cdr.
      (let ((new-pair (mcons item '())))
        (cond 
          ;; Si la cola está vacía:
          ((empty-queue?)
          ;; Ambos punteros (front y rear) apuntan al nuevo par.
          (set-front-ptr! new-pair)
          (set-rear-ptr! new-pair))
          ;; Si la cola no está vacía:
          (else 
          ;; Actualizamos el cdr del último par para que apunte al nuevo par.
          (set-mcdr! rear-ptr new-pair)
          ;; Cambiamos el puntero trasero para que apunte al nuevo par.
          (set-rear-ptr! new-pair)))))

    ;; Función para obtener el primer elemento de la cola.
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (mcar front-ptr))) ; Devuelve el car del puntero delantero.

    ;; Función para eliminar el primer elemento de la cola.
    (define (delete-queue!)
      (if (empty-queue?)
          (error "DELETE! called with an empty queue")
          (set! front-ptr (mcdr front-ptr)))) ; Actualiza el puntero delantero.

    (define (set-front-ptr! new-front)
      (set! front-ptr new-front)) ; Actualiza el puntero delantero.

    (define (set-rear-ptr! new-rear)
      (set! rear-ptr new-rear)) ; Actualiza el puntero trasero.
    ;; Función de dispatch para manejar las operaciones de la cola.
    (define (dispatch m)
      (cond
        [(eq? m 'empty-queue?) empty-queue?]
        [(eq? m 'insert-queue!) insert-queue!]
        [(eq? m 'front-queue) front-queue]
        [(eq? m 'delete-queue!) delete-queue!]
        [else (error "Unknown operation -- QUEUE" m)]))

    dispatch))

; Ejemplo de uso

(define q (make-queue))

((q 'insert-queue!) 1) ; Inserta 1 en la cola
((q 'insert-queue!) 2) ; Inserta 2 en la cola
((q 'front-queue)) ; Muestra el primer elemento de la cola (1)
((q 'delete-queue!)) ; Elimina el primer elemento de la cola (1)
((q 'front-queue)) ; Muestra el nuevo primer elemento (2)
