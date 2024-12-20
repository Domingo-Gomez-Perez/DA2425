#lang racket


#|
**Exercise 3.53:** Without running the program,
describe the elements of the stream defined by

```
(define s (stream-cons 1 (add-streams s s)))
```

|#


#|

El primer elemento del stream s es 1, el segundo es la suma consigo mismo (1 + 1 = 2), el
tercer elemento es (2+2 = 4) y así sucesivamente, por lo que se puede ver que el siguiente elemento
del stream s es el doble al anterior.
|#