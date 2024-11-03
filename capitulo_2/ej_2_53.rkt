#lang racket
;Exercise 2.53: What would the interpreter print in response to evaluating each of the following expressions?

(list 'a 'b 'c)
;'(a b c)
(list (list 'george))
;'((george))
(cdr '((x1 x2) (y1 y2)))
;'((y1 y2))
(cadr '((x1 x2) (y1 y2)))
;'(y1 y2)
(pair? (car '(a short list)))
;#f
;memq busca un objeto en una lista, y devuelve la lista en la que se encuentra o #f si no se encuentra
(memq 'red '((red shoes) (blue socks)))
;#f
(memq 'red '(red shoes blue socks))
;'(red shoes blue socks)