#lang racket

(list 'a 'b 'c) ;`lista : '(a b c)
(list (list 'george)); (lista '(george)) =(('george))
(cdr '((x1 x2) (y1 y2))); ((y1 y2)) 
(cadr '((x1 x2) (y1 y2))); ((y1 y2)) 
(pair? (car '(a short list))); (pair? a) -> #f
(memq 'red '((red shoes) (blue socks))); #f mira la lista externa que no incluye al elemento 'red' solo incluye listas
(memq 'red '(red shoes blue socks)); (red shoes blue socks) Obtiene la lista a desde red hasta el final