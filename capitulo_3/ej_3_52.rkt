#lang racket

#|

**Exercise 3.52:** One common optimization of streams is that of
"memoization."  When the delayed part of a stream is evaluated, the
the result is cached or memorized for later.  This can avoid repeated
operations.  This exercise explores that idea.

Consider the sequence of expressions

```
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

```

What is the value of `sum` after each of the above expressions is
evaluated?  What is the printed response to evaluating the `stream-ref`
and `display-stream` expressions?  Would these responses differ if we had
implemented `(delay ⟨exp⟩)` simply as `(lambda () ⟨exp⟩)`
without using the optimization provided by `memo-proc`?  Explain.

|#


(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)
(define (stream-enumerate-interval start stop)
    (if (> start stop)
        empty-stream
        (stream-cons start 
                     (stream-enumerate-interval (+ start 1) stop))))

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(define x
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(define (display-stream s)
  (stream-for-each displayln s))


#|
What is the value of `sum` after each of the above expressions is
evaluated?  What is the printed response to evaluating the `stream-ref`
and `display-stream` expressions?  
|#

(stream-ref y 7)
#|
Va sumando todos los números que están entre el 1 y el 20, y cuando se encuentre el octavo numero par, es cuando se devuelve el valor,
en este caso es 136 (1,3,6,10,15,21,28,36,45,55,66,78,91,105,120,136).

|#
(stream-ref y 0)

#|
Va sumando todos los números que están entre el 1 y el 20, y cuando se encuentre el primer numero par, es cuando se devuelve el valor,
en este caso es 6 (0 + 1 = 1, 1 + 2 = 3 , 3 + 3 = 6) que es lo que se verá.

|#

(display-stream z)

#|
Va sumando todos los números que están entre el 1 y el 20, y se muestran los números que en cada iteración tras la suma
son múltiplos de 5 (1,3,6,10,15,21,28,36,45,55,66,78,91,105,120,136,153,171,190,210), y el último número que se muestra es 210.
|#


#|
Would these responses differ if we had
implemented `(delay ⟨exp⟩)` simply as `(lambda () ⟨exp⟩)`
without using the optimization provided by `memo-proc`?  Explain.

La diferencia radica en que al usar el delay junto a force se permite
memorizar el resultado de manera que solo se evalua una vez, ya que con el delay
se guarda una promesa del resultado y al usar el force se devuelve
el valor resultante de la expresión sin necesidad de volver a realizar el cálculo

En cambio, al no usar el delay cualquier cálculo se evalua de manera inmediata
al invocar a la función.

Entonces, el uso del delay mejor aspectos como complejidad temporal, espacial, facilidad
de escribir,facilidad de cambiar programas...
|#


(define (add-stream s1 s2)
  (cond
    ; Si s1 está vacío, devolver s2
    ((null? s1) s2)  
    
    ; Si s2 está vacío, devolver s1
    ((null? s2) s1)  
    
    ; Caso recursivo
    (else
     (stream-cons (+ (stream-first s1) (stream-first s2))  ; Sumar los primeros elementos
                  (add-stream (stream-rest s1) (stream-rest s2))))))  ; Recursión perezosa para el resto del flujo

; Crear los flujos de ejemplo
(define s1 (stream-cons 1 (stream-cons 2 (stream-cons 3 '()))))
(define s2 (stream-cons 4 (stream-cons 5 (stream-cons 6 '()))))

; Llamar a add-stream
(define resultado (add-stream s1 s2))

; Acceder a los primeros 3 elementos
(displayln (stream-first resultado))  ; 5 (1 + 4)
(displayln (stream-first (stream-rest resultado)))  ; 7 (2 + 5)
(displayln (stream-first (stream-rest (stream-rest resultado))))  ; 9 (3 + 6)

;La función add-stream sin el uso de map toma dos flujos, s1 y s2, y devuelve un nuevo flujo en el que cada elemento es la suma de los primeros
;elementos de s1 y s2. Luego, el proceso se repite recursivamente para el resto de los flujos.la función crea un flujo cuyos primeros elementos
;son las sumas de los primeros elementos de s1 y s2, y el resto de los elementos se obtiene recursivamente.
