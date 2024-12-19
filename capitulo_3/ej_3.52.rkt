#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 3.52: One common optimization of streams is that of "memoization." When the delayed part of a
stream is evaluated, the result is cached or memorized for later. This can avoid repeated operations.
This exercise explores that idea.

Consider the sequence of expressions

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map
   accum
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z
  (stream-filter
   (lambda (x)
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)

What is the value of sum after each of the above expressions is evaluated? What is the printed response
to evaluating the stream-ref and display-stream expressions? Would these responses differ if we had implemented
 (delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) without using the optimization provided by memo-proc? Explain.
|#

; necesarias
(define (stream-enumerate-interval low high)
  (if (> low high)
      empty-stream
      (stream-cons low (stream-enumerate-interval (+ low 1) high))))

; Referencia por índice:
(define (stream-ref s n)
  (if (= n 0)
      (stream-first s)
      (stream-ref (stream-rest s) (- n 1))))

; Mapeo (aplicar una función a cada elemento):
(define (stream-map proc s)
  (if (stream-empty? s)
      empty-stream
      (stream-cons (proc (stream-first s)) (stream-map proc (stream-rest s)))))

; Iterar sobre un stream:
(define (stream-for-each proc s)
  (if (stream-empty? s)
      'done
      (begin
        (proc (stream-first s))
        (stream-for-each proc (stream-rest s)))))

; Stream-for-each is useful for viewing streams:
(define (display-stream s)
  (stream-for-each displayln s))

; funciones del ejercicio
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq
  (stream-map
   accum
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z
  (stream-filter
   (lambda (x)
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
(display-stream z)


; What is the value of sum after each of the above expressions is evaluated?

; Inicialmente, la variable sum se define con un valor de 0. El método accum suma un número pasado como argumento 
; a la variable sum y devuelve el valor actualizado de sum. Luego, el método seq registra una copia del valor inicial 
; de sum antes de ejecutarse. Al finalizar, sum será igual a la suma de la secuencia: sum = 1 + 2 + 3 + ... + 20 = 210.

; Sin embargo, si se llama al método seq nuevamente, no acumula el valor de sum calculado previamente, ya que no se guarda en memoria. 
; Por lo tanto, el valor de sum volvería a ser 210.

; What is the printed response to evaluating the stream-ref and display-stream expressions?
; Al evaluar stream-ref, se imprime el octavo elemento par en seq (los indices van de 0-7), por lo que primero se obtendria "y" 
; que es un flujo que contiene los elementos pares de seq y luego se obtendría el octavo elemento que es 136.

; Al evaluar display-stream, se imprime una lista con los elementos multiplos de 5 en seq (los indices van de 0-7), por lo que
; se mostraría los elementos en consola: 10 15 45 55 105 120 190 210. 

