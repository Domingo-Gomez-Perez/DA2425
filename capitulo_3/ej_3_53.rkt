#lang racket


#|
**Exercise 3.53:** Without running the program,
describe the elements of the stream defined by

```
(define s (stream-cons 1 (add-streams s s)))
```

|#


#|
Respuesta:
El primer elemento del stream s es 1, el segundo es la suma consigo mismo (1 + 1 = 2), el
tercer elemento es (2+2 = 4) y así sucesivamente, por lo que se puede ver que el siguiente elemento
del stream s es el doble al anterior (1,2,4,8,16,32,...).
|#


(define (stream-map proc s)
    (if (stream-empty? s) 
        empty-stream
        (stream-cons (proc (stream-first s))
                     (stream-map proc (stream-rest s)))))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s)))


