#lang racket

#|
**Exercise 3.54:** Define a procedure
`mul-streams`, analogous to `add-streams`, that produces the
elementwise product of its two input streams.  Use this together with the
stream of `integers` to complete the following definition of the stream
whose nth element (counting from 0) is `n + 1` factorial:

```
(define factorials 
  (cons-stream 1 (mul-streams ⟨??⟩ ⟨??⟩)))
```

|#


(define (integers-starting-from n)
  (stream-cons
   n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (mul-streams s1 s2)
  (if (null? s1)
      empty-stream
      (stream-cons
       (* (stream-first s1) (stream-first s2))
       (mul-streams (stream-rest s1) (stream-rest s2)))))


(define factorials 
  (stream-cons 1 (mul-streams integers factorials)))


;Ejemplo de uso
(display (stream-ref factorials 0)) ; 1
(newline)
(display (stream-ref factorials 1)) ; 1
(newline)
(display (stream-ref factorials 2)) ; 2
(newline)
(display (stream-ref factorials 3)) ; 6
(newline)
(display (stream-ref factorials 4)) ; 24
(newline)
(display (stream-ref factorials 5)) ; 120
(newline)