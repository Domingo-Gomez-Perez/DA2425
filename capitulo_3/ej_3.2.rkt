#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.2: In software-testing applications, it is useful to be able to count the number of times
a given procedure is called during the course of a computation. Write a procedure make-monitored that
takes as input a procedure, f, that itself takes one input. The result returned by make-monitored is
a third procedure, say mf, that keeps track of the number of times it has been called by maintaining
an internal counter. If the input to mf is the special symbol how-many-calls?, then mf returns the
value of the counter. If the input is the special symbol reset-count, then mf resets the counter to
zero. For any other input, mf returns the result of calling f on that input and increments the counter.
For instance, we could make a monitored version of the sqrt procedure:

(define s (make-monitored sqrt))

(s 100)
10

(s 'how-many-calls?)
1

Note: This exercise is similar to writing a decorator in Python.
|#

(define (make-monitored f)
  (define cont 0)
  (define (mf x)
    (cond
      [(eq? x 'how-many-calls?) cont] ; Se devuelve el contador con su valor actual
      [(eq? x 'reset-count)
       (begin
         (set! cont 0)
         cont)] ; Se reestablece el contador a 0 y se devuelve
      [else
       (begin
         (set! cont (+ cont 1))
         (f x))])) ; Si se llama al procedimiento, se ejecuta y se incrementa el contador
  mf)

(define s (make-monitored sqrt))

; Pruebas
(s 100) ; -> 10
(s 100) ; -> 10
(s 'how-many-calls?) ; -> 2
(s 'reset-count) ; -> 0
(s 'how-many-calls?) ; -> 0
