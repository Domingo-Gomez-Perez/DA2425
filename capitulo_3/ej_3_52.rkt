#lang racket

; Exercise 3.52

; One common optimization of streams is that of "memoization." When
; the delayed part of a stream is evaluated, the result is cached 
; or memorized for later. This can avoid repeated operations. This 
; exercise explores that idea.



; Auxiliary methods

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (stream-enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start (stream-enumerate-interval (+ start 1) stop))))



; Consider the sequence of expressions

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map accum (stream-enumerate-interval 1 20)))

(define y (stream-filter 
            even?                                ; Multiple of 2
            seq))

(define z (stream-filter 
            (lambda (x) (= (remainder x 5) 0))   ; Multiple of 5
            seq))

(stream-ref y 7)

(display-stream z)





; What is the value of `sum` after each of the above expressions is evaluated? 

; Before calling `(stream-ref y 7)`, sum is 0 because it has not been evaluated yet.
;
; After calling `(stream-ref y 7)`, sum is 136 because `y` uses a `stream-filter`
; so it ends up evaluating in the stream-ref only up to index 7.
;
; After calling `(display-stream z)`, sum is 210 because `display-stream`
; evaluates the entire stream and therefore sum reaches its maximum value.
 



; What is the printed response to evaluating the `stream-ref` and `display-stream` expressions? 


; `(stream-ref y i)` evaluates the stream at the end and only up to index `i`.
; In this case `(stream-ref y 7)` returns 136.
;
; If we evaluated `seq` completely, `seq` = [1,3,6,10, ..., 190,210]. From here,
; `y` would extract the `evens`, [6, 10, 28, 36, 66, 78, 120, 136, 190, 210].
;
; However, as we said, it would not be evaluated completely, only up to index
; 7, so `y` = [6, 10, 28, 36, 66, 78, 120, 136, pending...]. Therefore, it
; returns the value 136.


; `(display-stream z)` evaluates `z` completely. In turn, `z` gets from `seq`
; all the multiples of 5. Finally, `display-stream` displays each element on
; the console after being evaluated.




; Would these responses differ if we had implemented `(delay ⟨exp⟩)` simply as
; `(lambda () ⟨exp⟩)` without using the optimization provided by `memo-proc`? 

; Indeed, if we had implemented (delay <exp>) in a less optimal way like
; (lambda () <exp>), the result would be different. Instead of returning
; a `promise`, we would be evaluating the expression. Resulting into huge 
; behavior differences.