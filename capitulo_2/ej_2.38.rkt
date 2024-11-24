#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.38: The procedure accumulate is also known as fold-right, because it
combines the first element of the sequence with the result of combining all the
elements to the right. There is also a fold-left, which is similar to fold-right,
except that it combines elements working in the opposite direction:



What are the values of:

(fold-right / 1 (list 1 2 3))
(fold-right / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left  list null (list 1 2 3))

Give a property that op should satisfy to guarantee that fold-right and fold-left
will produce the same values for any sequence.

|#

#|
La funcion accumulate pero llamada fold-right
|#

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; de el inicial, va haciendo la operacion hacia la derecha uno por uno acumulando
(fold-left  * 1 (list 1 2 3))
(fold-left  / 1 (list 1 2 3)) ; (((1/1)/2)/3)
(fold-left  list null (list 1 2 3))

; ahora el right, esta vez va desde la derecha a la izquierda, mas simple al solo tener que ser recursivo
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(fold-right  * 1 (list 1 2 3))
(fold-right  / 1 (list 1 2 3)); 1/(2/(3/1)) al ser el dividir uno debajo de otro, uno pasa a multiplicar, otro divide...
(fold-right  list null (list 1 2 3)); vemos que va desde el final


#|
Para que fold-right y fold-left produzcan los mismos valores, es necesario que la operación
sea "conmutativa", es decir, que de igual empezar por la derecha que por la izquierda. Esto
es porque no es lo mismo "2/3" que "3/2"; sin embargo, si es lo mismo "1+2 que "2+1".
Estos dos ejemplos: "(fold-right * 1 (list 1 2 3))" y "(fold-right * 1 (list 1 2 3))"
si dan lo mismo, por su parte. 
|#