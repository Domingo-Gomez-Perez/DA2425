#lang racket


#|
**Exercise 1.16:** Design an iterative version of the `fast-expt`
procedure given in the text.  Hint: to do this, it might help to use a
subtle trick of algorithm design.  Normally when implementing an
algorithm, you're thinking about how to break a problem down into
smaller and smaller steps (e.g., subdividing the problem into parts).  However,
sometimes it might make sense to change the problem into a different, but
equivalent problem.  For example, suppose you were computing
`2^16`. You could rewrite this problem by doubling the base and halving the exponent.
Thus, it's really the same as computing `4^8`.  Perhaps this trick could be used
in your solution.
|#



;Versión recursiva

(define (square n)
  (* n n))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n)    ;comprueba si n es par
         (square (fast-expt b (/ n 2))))
        (else         ; en caso contrario
         (* b (fast-expt b (- n 1))))))

(fast-expt 2 4)


;Versión iterativa

(define (fast-expt-iter b n resultado)
  (cond ((= n 0) 
         resultado)
        ((even? n)    ;comprueba si n es par
         (square (fast-expt-iter b (/ n 2) resultado)))
        (else         ; en caso contrario, es decir si el exponente es impar
         (* b (fast-expt-iter b (- n 1) resultado)))))


(define (fast-expt-res b n)
  (fast-expt-iter b n 1))



(fast-expt-res 3 4)

#|
Esto es lo que sucedería con 3 ^ 4 de la forma que he implementado el método fast-expt-res que
es iterativo.

(fast-expt-res 3 4)

(fast-expt-iter 3 4 1)  el exponente es par (4)

(square (fast-expt-iter 3 2 1)) el exponente es par (2)


(square(square (fast-expt-iter 3 1 1))) el exponente es impar (1)


(square(square ( 3 * (fast-expt-iter 3 0 1 )))) el exponente es 0 (n = 0)

(square(square ( 3 * (resultado))))

(square(square ( 3 * 1)))

Como n = 0, es decir el valor del exponente ha llegado a 0 en la función recursiva se retornara la operación siguiente en función
 del valor de la variable resultado a la función iterativa "fast-expt-res" :

((3 * 1) ^ 2 ) ^ 2 = 9 ^ 2 = 81.

Este valor es el que muestra la función iterativa.
|#