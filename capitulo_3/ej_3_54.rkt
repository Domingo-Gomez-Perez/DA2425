#lang racket
;Exercise 3.54: Define a procedure mul-streams, analogous to add-streams, that produces the elementwise product of its two input streams.
;Use this together with the stream of integers to complete the following definition of the stream whose nth element (counting from 0) is n + 1 factorial:

;(define factorials 
;  (cons-stream 1 (mul-streams ⟨??⟩ ⟨??⟩)))


;Funciones del reading 3.5.2
(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

;Stream map da error asi que tendremos que crear nuestro propio basandonos en: El fallo es debido a que nuestro stream-map solo funciona originalmente para funciones que reciben un solo parametro
;, por lo tanto tendremos que hacer uno modificado que sirva para 2
;(define (stream-map proc s)
;  (if (stream-null? s)
;      the-empty-stream
;      (cons-stream 
;       (proc (stream-car s))
;       (stream-map proc (stream-cdr s)))))

(define (stream-map2 proceso x y)
  (if (stream-empty? x) ;comprobamos si el stream esta vacio en vez de que si es nulo y devolvemos un stream vacio
      empty-stream
      (stream-cons (proceso (stream-first x) (stream-first y)) ;Ejecutamos el proceso sobre los primeros elementos de x e y y de forma recursiva se aplica sobre el resto de elementos
                   (stream-map2 proceso (stream-rest x) (stream-rest y)))));De forma que al final se juntan todos en un mismo stream

;Definimos mul-streams
(define (mul-streams s1 s2) 
  (stream-map2 * s1 s2))

(define factorials 
  (stream-cons 1 (mul-streams factorials integers)));Multiplicamos el factorial anterior por el numero entero que toca

;Damos ejemplos para probar que funciona
(stream-ref factorials 1);1
(stream-ref factorials 2);2
(stream-ref factorials 3);6
(stream-ref factorials 4);24
(stream-ref factorials 5);120
(stream-ref factorials 6);720
(stream-ref factorials 7);5040
(stream-ref factorials 8);40320
(stream-ref factorials 9);362880
