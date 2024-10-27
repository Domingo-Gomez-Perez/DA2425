#lang racket

#|
Hecho por
EZQUERRA CEBALLOS, CARLOS
FERNÁNDEZ RIVERA, CRISTIAN MANUEL
GOMEZ GARCIA, GABRIEL
MUÑOZ FERNANDEZ, PAULA

Exercise 2.53: What would the interpreter print in response to evaluating
each of the following expressions?

(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))
|#

(list 'a 'b 'c)
; es lo mismo que usar '(a b c) todo se junta en una quote

(list (list 'george))
; una lista que tiene dentro una lista con george '((george))

(cdr '((x1 x2) (y1 y2)))
; un quote que tiene dentro 2 listas, car cogeria la primera, cdr lo rstante
; es decir, '((y1 y2)). Ademas se encuentra una lsita dentro de un quote por lo que doble parentesis

(cadr '((x1 x2) (y1 y2)))
(car (cdr '((x1 x2) (y1 y2)))) ; lo mismo
; cadr es lo mismo que usar (car (cdr ...)), asi da el primer y unico elemento de la
; segunda lista: '((y1 y2)) por lo que devuelve (y1 y2)

(pair? (car '(a short list)))
; pair mira si el argumento es una lista no vacia. Como car de esa quote devuelve
; el primer elemento "a" no va ser una lista, solo el elemento por lo que es falso
; si usamos (pair? '(a short list)) entonces si lo es o (pair? (cdr '(a short list)))

(memq 'red '((red shoes) (blue socks)))
; memq mira si red esta contenido en la lista, sin embarlo se trata de una lista de listas
; y no va mirando dentro de esas listas, solo superficialmente por lo que solo ve que hay 2 listas
; y ninguna es red asi que faslo.

(memq 'red '(red shoes blue socks))
(memq 'red '(shoes blue socks red))
; aqui si que esta red en la lista por lo que va a devolver toda la sublista desde red hasta el final
; si fuera (memq 'red '(shoes blue socks red)) entonces solo red