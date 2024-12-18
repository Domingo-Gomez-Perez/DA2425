#lang racket

; Exercise 3.12

; The following procedure for appending lists was introduced
; in 2.2.1.  It has been modified for use in Racket specifically
; for this exercise.


(define (append x y)
  (if (null? x)
      y
      (mcons (mcar x) (append (mcdr x) y))))


; `Append` forms a new list by successively `cons`ing the elements
; of `x` onto `y`.  The procedure `append!` is similar to `append`,
; but it is a mutator rather than a constructor.  It appends the
; lists by splicing them together, modifying the final pair of `x`
; so that its `cdr` is now `y`. 
; (It is an error to call `append!` with an empty `x`.)


(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)



; Here `last-pair` is a procedure that returns the last pair in its argument:

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))



(define x (mcons 'a (mcons 'b null)))
(define y (mcons 'c (mcons 'd null)))


; Consider the interaction. What are the missing `⟨response⟩`s?  
; Draw box-and-pointer diagrams to explain your answer.



(define z (append x y))
z

; Primero llamamos (append x y) con:
; x = [ a | o ]---> [ b | '() ]
; y = [ c | o ]---> [ d | '() ]

; Aplicamos (mcons (mcar x) (append (mcdr x) y))
;   (mcar x) = 'a
;   (mcdr x) = [ b | '() ]
;   (append (mcdr x) y) = (append [ b | '() ] y)

; Volvemos a llamar (append x y) con:
; x = [ b | '() ]
; y = [ c | o ]---> [ d | '() ]

; Aplicamos (mcons (mcar x) (append (mcdr x) y))
;   (mcar x) = 'b
;   (mcdr x) = '()
;   (append (mcdr x) y) = (append '() y)

; Volvemos a llamar (append x y) con:
; x = '()
; y = [ c | o ]---> [ d | '() ]
; x es null por lo que devuelvo y

; Vamos hacia atrás y retornamos finalmente:
; [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]

; Al acabar, vemos que las variables x, y no han cambiado
; x = [ a | o ]---> [ b | '() ]
; y = [ c | o ]---> [ d | '() ]
; z = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]


(mcdr x)

; Respuesta: Al no cambiar x,  (mcdr x) sigue siendo...
; (mcons 'b '())

 




(define w (append! x y))
w


; Primero llamamos (append! x y) con:
; x = [ a | o ]---> [ b | '() ]
; y = [ c | o ]---> [ d | '() ]

; Aplicamos (set-mcdr! (last-pair x) y)
;   (mcdr x) = [ b | '() ]
;   (last-pair (mcdr x)) = (last-pair [ b | '() ])

; Llamamos (last-pair x) con:
;   x = [ b | '() ]
;
;   (mcdr x) = '()
;   Como es null, devuelvo x = [ b | '() ]

; Vamos hacia atrás y ejecutamos (set-mcdr! (last-pair x) y) con:
;   (last-pair x) = [ b | '() ]
;   y = [ c | o ]---> [ d | '() ]
;
;   transforma (mcdr x) en [ b | o ]---> [ c | o ]---> [ d | '() ]
;   retorna x = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]

; Al acabar, vemos que las variables x, y no han cambiado
; x = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]
; y = [ c | o ]---> [ d | '() ]
; z = [ a | o ]---> [ b | o ]---> [ c | o ]---> [ d | '() ]


(mcdr x)

; Respuesta: Al no cambiar x,  (mcdr x) sigue siendo...
; (mcons 'b '())