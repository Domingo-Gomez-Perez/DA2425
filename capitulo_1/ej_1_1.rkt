#lang racket

#|
**Exercise 1.1:** Below is a sequence of expressions.
What is the result printed by the interpreter in response to each expression?
Assume that the sequence is to be evaluated in the order in which it is
presented.
|#

10 ;el resultado de esto es 10 y es lo que se muestra
;porque así lo interpreta 

(+ 5 3 4)#|el resultado es 12 y es lo que se muestra porque se suma primero 5 y 3 y el resultado
|de esta suma se suma con 4
|#

(- 9 1); el resultado es 8 y es lo que se muestra
;porque es la resta de 9 y 1

(/ 6 2); el resultado es 3 y es lo que muestra
;porque es la división entre 6 y 2

(+ (* 2 4) (- 4 6))#|el resultado es 6 y es lo que muestra porque hace en primer lugar lo que se encuentra
 dentro de los paréntesis, es decir, primero hace la multiplicación
de 4 y 2; después hace la resta entre 4 y 6; y finalmente se suman
los resultados de las operaciones anteriores, es decir, suma 8 y -2

|#

(define a 3)


(define b (+ a 1))

(+ a b (* a b))#|El resultado es 19 y es lo que se muestra 
tras haber definido anteriormente a con el valor 3 y b con el valor de
 a + 1; es decir, 4, lo que hace primero es lo que se encuentra
dentro del paréntesis, es decir, multiplica 3 y 4, obteniendo
como resultado 12 y después suma esto con los valores de a y b;
es decir suma 12 con 4 y 3 con resultado 19.
|#

(= a b)#|Muestra el resultado de la comparación entre a y b,
es decir, compara si 3(a) y 4(b) son iguales, como son distintos
se muestra #f (false) que indica que es falso que 3 y 4 sean iguales 
|#



(if (and (> b a) (< b (* a b)))
    b
    a)#|Muestra el resultado de la operación AND de los resultados
 de las comparaciones de si b(4)
es mayor que a(3) y compara si b(4) es menor que el resultado
de multiplica los valores de a(3) y b(4); es decir, hace un AND de True
(b es mayor que a) y True, al hacer esta operación AND lo que se
muestra es el valor de b (4), en caso contrario, se mostraría el valor de a
|#
    
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))#|Compara si a es igual que 4 y como no se cumple pasa
a la otra comparación, es decir, compara si b es igual que 4 y esto
si se cumple, por lo tanto, suma 6, 7 y el valor de a(3);por lo tanto
se muestra el valor de esta suma que es 16 ; y es cuando
ya no se compara más porque ya hay una condición que se ha cumplido.

|#


(+ 2 (if (> b a) b a))#|En primer lugar compara si b(4) es mayor que a(3), esto se cumple,
por lo tanto, lo que se obtiene tras esta comparación que es el valor
de b(4) se suma con 2, y mostrandose como resultado 6.
|#


(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))#|Primero compara si a(3) es mayor que b(4), y como no se cumple, pasa
a la otra comparación en la que se compara si a es menor que b, y esto se cumple,
por lo tanto, el resultado de esta condición que si se cumple
que es b(4) se multiplica con el resultado de la suma de a y 1 (4),
teniendo como resultado 16 que es lo que se muestra
|#
