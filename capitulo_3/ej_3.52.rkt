#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.52: One common optimization of streams is that of "memoization." When the delayed part of a
stream is evaluated, the result is cached or memorized for later. This can avoid repeated operations.
This exercise explores that idea.

Consider the sequence of expressions

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map
   accum
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z
  (stream-filter
   (lambda (x)
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)

What is the value of sum after each of the above expressions is evaluated? What is the printed response
to evaluating the stream-ref and display-stream expressions? Would these responses differ if we had implemented
 (delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) without using the optimization provided by memo-proc? Explain.
|#
