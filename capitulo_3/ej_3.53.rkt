#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.53: Without running the program, describe the elements of the stream defined by

(define s (stream-cons 1 (add-streams s s)))
|#

; hemos tenido que crear un stream-map custom para poder hacerlo bien ya que el normal no funcionaba
(define (custom-stream-map proc stream1 stream2)
  (if (stream-empty? stream1)
      empty-stream
      (stream-cons (proc (stream-first stream1) (stream-first stream2))
                   (custom-stream-map proc (stream-rest stream1) (stream-rest stream2)))))

; Función para sumar streams
(define (add-streams s1 s2)
  (custom-stream-map + s1 s2))

; Definición del stream s
(define s (stream-cons 1 (add-streams s s)))

(list (stream-ref s 0) (stream-ref s 1) (stream-ref s 2) (stream-ref s 3) (stream-ref s 4))

#| El primer elemento de s es simplemente 1 debido a stream-cons 1 ....
El segundo elemento de s es la suma de los primeros elementos de s consigo mismo, es decir, 1 + 1 = 2.
El tercer elemento de s es la suma de los segundos elementos de s consigo mismo, es decir, 2 + 2 = 4.
El cuarto elemento de s es la suma de los terceros elementos de s consigo mismo, es decir, 4 + 4 = 8.
El quinto elemento de s es la suma de los cuartos elementos de s consigo mismo, es decir, 8 + 8 = 16.

De esta manera se estan sumando los elementos de s consigo mismo, por lo que se puede ver que el stream s es una lista con las potencias de 2.

Pero tambien hay otra opcion ya que como no lo estamos haciendo con el stream map original, igual el funcionamiento es el siguiente:

El primer elemento es 1.
El segundo elemento es 1 + 1 = 2.
El tercer elemento es 1 + 2 = 3.
El cuarto elemento es 2 + 3 = 5.
El quinto elemento es 3 + 5 = 8.
El sexto elemento es 5 + 8 = 13.

Y asi genera la secuencia de fibonacci. Esto es asi ya que al hacer s + s estamos sumando cada elemento con el siguiente elemento de la secuencia.
Es decir, al llamar a add stream s s, el primer s ya coge un elemento y el segundo s coge el siguiente elemento de la secuencia. Por lo tanto,
se suma el actual con el siguiente. |#
