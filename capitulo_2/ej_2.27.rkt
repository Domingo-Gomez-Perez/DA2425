#lang racket

#|
Hecho por:
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.27: Modify your reverse procedure of Exercise 2.18 to produce a
deep-reverse procedure that takes a list as argument and returns as its value
the list with its elements reversed and with all sublists deep-reversed as well.
For example,

(define x
  (list (list 1 2) (list 3 4)))

x
; => ((1 2) (3 4))

(reverse x)
; => ((3 4) (1 2))

(deep-reverse x)
; => ((4 3) (2 1))
|#

(define (deep-reverse lista)
  (if (null? lista)
      null  ;; Lista vacía
      (append (deep-reverse (cdr lista))  ;; Invertir recursivamente el resto de la lista
              (list (if (pair? (car lista))  ;; Si el primer elemento es una lista, invertirlo también
                        (deep-reverse (car lista))
                        (car lista))))))

; pruebas (todos los casos posibles)
(define x
  (list (list 1 2) (list 3 4)))

(define y
  (list (list 1)))

(define z
  (list (list 1 2)))

(define a
  (list (list)))

(define b
  (list 1 2))

(define c
  (list (list 3 4) 1 2))


x
; => ((1 2) (3 4))

(deep-reverse x)
; => ((3 4) (1 2))

(deep-reverse y)
; => ((4 3) (2 1))

(deep-reverse z)

(deep-reverse a)

(deep-reverse b)

(deep-reverse c)



