#lang racket

; **Exercise 2.25:** Give combinations of `car`s
; and `cdr`s that will pick 7 from each of the following lists:

; ```
; (1 3 (5 7) 9)
; ((7))
; (1 (2 (3 (4 (5 (6 7))))))
; ```

(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
;(car (cdr (car (cdr (3 (5 7) 9)))))
;(car (cdr (car (5 7) 9)))
;(car (cdr (5 7)))
;(car 7)
;7

(car (car '((7))))
;(car (7))
;(7)

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))
;primer cdr: Selecciona el segundo elemento de la entrada (en este caso la entrada es [1, listaX])
;primer car: Selecciona el primer elemento de la listaX
; .
; .
; .
;(car (cdr (car '((6 7)))))
;(car (cdr '(6 7)))
;(car '(7))
;(7)
