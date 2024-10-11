#lang racket

#|

**Challenge Exercise:** In Exercise 2.6, the Church numerals were defined.
If `x` and `y` are Church numerals, can you define subtraction?

```
; Returns a procedure representing x - y
(define (sub x y) ...)
```
|#



(define zero (lambda (f) (lambda (x) x)))


(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f(f x)))))

(define three
  (lambda (f) (lambda (x) (f(f(f x))))))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (incremento x)
  (+ x 1))



(define (sub x y)
  (lambda (f) (lambda (z) ((x f) (* -1 ((y f) z)))))
)


(((sub one three)incremento) 0)

