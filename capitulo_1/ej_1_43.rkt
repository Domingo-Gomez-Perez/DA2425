#lang racket

#|
**Exercise 1.43:** If `f` is a numerical function
and `n` is a positive integer, then we can form the nth repeated
application of `f`, which is defined to be the function whose value at `x`
is `f(f(...(f(x))))`.  For example, if `f` is the
function that maps `x` to `x+1`, then the nth repeated application of `f` is
the function that maps `x` to `x+n`. If `f` is the operation of squaring a
number, then the nth repeated application of `f` is the function that
raises its argument to the `2^n` power.  Write a procedure that takes as
inputs a procedure that computes `f` and a positive integer `n` and returns
the procedure that computes the nth repeated application of `f`.  Your
procedure should be able to be used as follows:

```
((repeated square 2) 5)    ;-> 625
```

Hint: You may find it convenient to use `compose` from Exercise 1.42.
|#



(define (compose f g)
  (lambda (x) (f(g x))))
(define (square n) (* n n))
(define (inc n) (+ n 1))

(define (repeated f n)
(define (repeated-iter f f2 n)
  (if (= n 1)
 (lambda (x) (f x))
 (repeated-iter (compose f f2) f2 (- n 1)))
 )
(repeated-iter f f n))

((repeated square 4) 5)
  

;al hacerlo en recursiva si ponia el mismo f para compose para square3 me hacia 390625 ^2, me hacia uno mas





