#lang racket


#|

**Exercise 3.16:** Ben Bitdiddle decides to write a
procedure to count the number of pairs in any list structure.  "It's easy,"
he reasons.  "The number of pairs in any structure is the number in the
`car` plus the number in the `cdr` plus one more to count the current
pair."  So Ben writes the following procedure (modified for Racket):

```
(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))
```

Show that this procedure is not correct.  In particular, draw box-and-pointer
diagrams representing list structures made up of exactly three pairs for which
Ben's procedure would return 3; return 4; return 7; never return at all.  Encode
these diagrams as data structures using Racket `mcons`.
|#

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

#|
Respuesta:

Este procedimiento no realiza lo que se pide debido a que si cdr de un par apunta a sí mismo o a otra parte de
la estructura que ya se contabilizó, se puede llegar a producir un bucle infinito. Otro problema es si la misma
subestructura es referenciada desde varios lugares, la función la cuenta más de una vez.

1)El procedimiento de Ben retorna 3

Diagrama (Tres pares en una lista): 

[1 |---] --> [2 |---] --> [3 |---] --> '()


El código en Racket para esta estructura de datos es la siguiente:


(define lista3 (mcons 1 (mcons 2 (mcons 3 '()))))



2)El procedimiento de Ben retorna 4

Diagrama (Un par se comparte (se duplica referencia)):

[1 |---] --> [2 |---] --> '()
               ^
               |
          [2 |---] --> '()  (referencia al segundo par)



El código en Racket para esta estructura de datos es la siguiente:


(define compartido (mcons 2 '()))
(define lista4 (mcons 1 (mcons compartido compartido)))


Retorna 4 porque cuenta la variable compartido 2 veces y devuelve 4 en vez de 3.


3) El procedimiento de Ben retorna 7

Diagrama (Subestructura compartida y anidada):


       [1 |---] --> [3 |---] --> '()  (compartido2)
               ^
               |
          [1 |---] --> [3 |---] --> '()  (compartido2, compartido con el primer par)
                        ^
                        |
                   [3 |---] --> '()  (compartido2, compartido con el primer par)


El código en Racket para esta estructura de datos es la siguiente:

(define compartido2 (mcons 3 '()))
(define lista7 (mcons (mcons 1 compartido2) (mcons 1 (mcons compartido2 compartido2))))
(count-pairs lista7)


Retorna 7 porque cuenta la variable compartido varias veces y devuelve 7.

4) El procedimiento de Ben no termina nunca

Diagrama (Lista con ciclo):


[1 |---] --> [1 |---] --> [1 |---] --> ...  (bucle infinito)

(define ciclo (mcons 1 '()))
(set-mcdr! ciclo ciclo) ; Apunta a sí misma.


En este caso, el procedimiento entra en un bucle inifnito debido a que nunca llega al caso base porque al apuntar a
sí mismo mpair? siempre es cierto.


|#


;Ejemplo para 1)
(displayln "Ben's procedure returns 3")
(define lista3 (mcons 1 (mcons 2 (mcons 3 '()))))
(count-pairs lista3) ;retorna 3

;Ejemplo para 2)
(displayln "")
(displayln "Ben's procedure returns 4")

(define compartido (mcons 2 '()))
(define lista4 (mcons 1 (mcons compartido compartido)))
(count-pairs lista4) ;retorna 4

;Ejemplo para 3)
(displayln "")
(displayln "Ben's procedure returns 7")

(define compartido2 (mcons 3 '()))
(define lista7 (mcons (mcons 1 compartido2) (mcons 1 (mcons compartido2 compartido2))))
(count-pairs lista7) ;retorna 7

;Ejemplo para 4)

(define ciclo (mcons 1 '()))
(set-mcdr! ciclo ciclo)
;(count-pairs ciclo)