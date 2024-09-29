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


;Versión recursiva
(define (repeated f n)
  
  (if(= n 1)  
     (lambda (x) (f x))
     (lambda (y) ((repeated f (- n 1)) (f y)))))  ;tuve que crear otra función para que me distinga la una de la otra debido a que es la misma
      ;en realidad y no me itere más de lo debido

#|

((repeated square 3) 5)
(if(= n 1)(lambda (y) ((repeated f (- 3 1)) (f y))))
(lambda (5) ((repeated square (- 3 1)) (square 5)))
(lambda (5) ((repeated square 2) (square 5)))
(lambda (5) ((repeated square 1) (square(square 5))))
(if(= n 1) (lambda (x) (f x))(lambda (5) ((repeated square 1) (square(square 5))))) en este caso se cumple la primera y no la seguna ya que n
es igual a 1 pero hace lo mismo
(lambda (5) ((repeated square 1) (square(square(square 5)))))

((5^2)^2) ^ 2 = (625) ^2 = 390625

|#
  


;Otra forma
(define (repeated1 f n)
  (define (repeated-iter f f2 n)
    (if (= n 1)
        (lambda (x) (f x))
        (repeated-iter (compose f f2) f2 (- n 1))))
(repeated-iter f f n))


#|


((repeated1 square 3) 5)  =  ((5 ^ 2) ^ 2)^ 2
  (repeated-iter f f n)
  (repeated-iter (compose f f2) f2 (- n 1))
  (repeated-iter (compose square square) square (- 3 1))
  (repeated-iter (compose square square) square 2))
  (repeated-iter (compose (compose square square) square)  square 1))
  (if (= n 1)  (lambda (x) (f x)))
  (if (= n 1)  (lambda (5) (compose (compose square square) square 5)))
  (if (= n 1)  (lambda (5) (compose square(square) square 5)))
  (if (= n 1)  (lambda (5) (square(square(square 5)))))
   
   (square(square(square 5))))

   ((5^2)^2) ^ 2 = (625) ^2 = 390625
|#

((repeated1 square 3) 5)
 ((repeated square 3) 5)







