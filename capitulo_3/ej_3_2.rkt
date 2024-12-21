#lang racket
;Exercise 3.2: In software-testing applications, it is useful to be able to count the number of times a given procedure is called during the course of a computation.
;Write a procedure make-monitored that takes as input a procedure, f, that itself takes one input.
;The result returned by make-monitored is a third procedure, say mf, that keeps track of the number of times it has been called by maintaining an internal counter.
;If the input to mf is the special symbol how-many-calls?, then mf returns the value of the counter.
;If the input is the special symbol reset-count, then mf resets the counter to zero. For any other input, mf returns the result of calling f on that input and increments the counter.
;For instance, we could make a monitored version of the sqrt procedure:
(define (make-monitored f) (let ((contador 0))
                             (define (mf input)
                             (cond ((equal? input 'how-many-calls?) contador)
                                   ((equal? input 'reset-count) (set! contador 0))
                                   (else (begin  (set! contador (+ contador 1)) (f input)))))
  mf))


(define s (make-monitored sqrt))

(s 100)
;10

(s 'how-many-calls?)
;1

(s 9)
;3

(s 'how-many-calls?)
;2

(s 'reset-count)

(s 'how-many-calls?)
;0

(s 1)
;1

(define s2 (make-monitored sqr))
(s2 2)
;4

(s2 'how-many-calls?)
;1