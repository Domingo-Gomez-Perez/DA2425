#lang racket
;Exercise 3.52: One common optimization of streams is that of "memoization."
;When the delayed part of a stream is evaluated, the the result is cached or memorized for later. This can avoid repeated operations. This exercise explores that idea.

;Consider the sequence of expressions

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define (stream-enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (stream-enumerate-interval (+ start 1) stop))))

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(define (stream-car stream) (stream-first stream))
(define (stream-cdr stream) (force (stream-rest stream)))

(define (display-stream s)
     (if (null? s) '()
         (if (stream-empty? s) '()
         (begin (display (stream-car s))
                (newline)
                (display-stream (stream-cdr s))))))



;What is the value of sum after each of the above expressions is evaluated?

;(define seq 
;  (stream-map 
;   accum 
;   (stream-enumerate-interval 1 20)))
;sum = 1
;(define y (stream-filter even? seq))
;sum = 6
;(define z 
;  (stream-filter 
;   (lambda (x) 
;     (= (remainder x 5) 0)) seq))

;sum = 10

;What is the printed response to evaluating the stream-ref and display-stream expressions?

(stream-ref y 7)
;Devuelve el septimo numero par del stream y, 136
(display-stream z);Muestra todo el stream z
;10
;15
;45
;55
;105
;120
;190
;210
;'() = FIN

;Would these responses differ if we had implemented (delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) without using the optimization provided by memo-proc? Explain.

;Si delay se implementa como (lambda () ⟨exp⟩) sin memoization:

;Cada vez que accede a una parte distinta volvera a ejecutar toda la computacion, para stream-ref y 7, se llamara repetidamente a accum, incrementando sum varias veces.
;Esto probablemente cambie el valor del 7º numero de y, cambiando el resultado.
;Para display-stream z, iterar sobre z recalculará todos los anteriores, aumentando mucho el valor de sum debido a múltiples evaluaciones.