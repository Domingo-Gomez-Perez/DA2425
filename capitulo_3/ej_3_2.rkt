#lang racket

#|

**Exercise 3.2:** In software-testing applications,
it is useful to be able to count the number of times a given procedure is
called during the course of a computation.  Write a procedure
`make-monitored` that takes as input a procedure, `f`, that itself
takes one input.  The result returned by `make-monitored` is a third
procedure, say `mf`, that keeps track of the number of times it has been
called by maintaining an internal counter.  If the input to `mf` is the
special symbol `how-many-calls?`, then `mf` returns the value of the
counter.  If the input is the special symbol `reset-count`, then `mf`
resets the counter to zero.  For any other input, `mf` returns the result
of calling `f` on that input and increments the counter.  For instance, we
could make a monitored version of the `sqrt` procedure:

```
(define s (make-monitored sqrt))

(s 100)
10

(s 'how-many-calls?)
1
```

Note: This exercise is similar to writing a decorator in Python.
|#


(define (make-monitored funcion)
  (define contador 0)  ; Inicializa el contador en 0.
  (define (mf result)
    (cond
      ((eq? result 'how-many-calls?) contador)  ; Devuelve el contador actual.
      ((eq? result 'reset-count) (begin
                              (set! contador 0)  ; Resetea el contador a 0.
                              contador))         ; Devuelve el nuevo valor (0).
      (else (begin
              (set! contador (+ contador 1))   ; Incrementa el contador.
              (funcion result)))))                  ; Llama a la función original con el argumento x.
  mf)  ; Retorna la función monitoreada.



(define s (make-monitored sqrt))

(s 100)


(s 'how-many-calls?)