#lang racket

(display"\nExercise 2.53\n")

; **Exercise 2.53:** What would the interpreter print
; in response to evaluating each of the following expressions?


(list 'a 'b 'c)
;Salida: '(a b c)
(list (list 'george))
;Salida: '((george))
(cdr '((x1 x2) (y1 y2)))
;Salida: '((y1 y2))
(cadr '((x1 x2) (y1 y2)))
;Salida: '(y1 y2)
(pair? (car '(a short list)))
;Salida: #f
(memq 'red '((red shoes) (blue socks)))
;Salida: #f
(memq 'red '(red shoes blue socks))
;Salida: '(red shoes blue socks)

