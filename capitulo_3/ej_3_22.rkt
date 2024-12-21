#lang racket
;Exercise 3.22: Instead of representing a queue as a pair of pointers, we can build a queue as a procedure with local state. The local state will consist of pointers to the beginning and the end of an ordinary list.
;Thus, the make-queue procedure will have the form

;(define (make-queue)
;  (let ((front-ptr … )
;        (rear-ptr … ))
;    ⟨definitions of internal procedures⟩
;    (define (dispatch m) …)
;    dispatch))

;Complete the definition of make-queue and provide implementations of the queue operations using this representation.

(define (make-queue)
  (let ((front-ptr '());Definimos inicialmente el puntero inicial y final a vacio.
        (rear-ptr '()))

    (define (empty?);Comprobaremos si la lista esta vacia mirando si el puntero frontal es null
      (null? front-ptr))

    (define (insert-queue! item)
      (let ((new-item (mcons item '()))) ; Creamos un par objeto que no apunte a nada
        (if (empty?)
            (begin
              (set! front-ptr new-item) 
              (set! rear-ptr new-item)) ; Si esta vacia el puntero inicial y final deben apuntar al nuevo nodo
            (begin
              (set-mcdr! rear-ptr new-item) ; Añadimos el nuevo nodo al puntero final
              (set! rear-ptr new-item))))) ; El nuevo puntero final debe ser el objeto que introducimos

    ;; Internal procedure to remove an element from the queue
    (define (delete-queue!)
      (if (empty?)
          (begin (display "Se ha usado delete con una cola vacia")
          (newline))
      (begin (set! front-ptr (mcdr front-ptr)) ; Avanzamos el nodo frontal
      (when (null? front-ptr) ; Si pasa a ser null debemos pasar el puntero final a null
        (set! rear-ptr '())))))

    ;; Internal procedure to return the front item without removing it
    (define (front)
      (if (empty?)
          (begin (display "Se ha usado Front sobre una cola vacia")
          (newline))
      (mcar front-ptr)))

    ;; Dispatch procedure to handle messages
    (define (dispatch m)
      (cond ((eq? m 'empty?) empty?)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            ((eq? m 'front) front)
            (else (error "Se ha elegido una operacion incorrecta en dispatch" m))))

    dispatch))

;; Example usage
(define q (make-queue))
((q 'front)) ;Comprobamos que de error al estar vacia
((q 'delete-queue!)) ;Comprobamos que de error al estar vacia
(newline)
((q 'insert-queue!) 'a) ;Inserta 'a
((q 'insert-queue!) 'b)
((q 'insert-queue!) 'c)
(display ((q 'front))) ;Devuelve 'a
(newline)
((q 'delete-queue!)) ;Elimina 'a
(newline)
(display ((q 'front))) ;Devuelve 'b
