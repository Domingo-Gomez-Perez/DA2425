#lang racket
(list 'a 'b 'c)
;Crea una lista con los elementos 'a 'b 'c
;Resultado: '(a,b,c)
(list (list 'george))
;Crea una lista de una lista de un elemento
;Resultado:'((george))
(cdr '((x1 x2) (y1 y2)))
;Devuelve todo excepto el primer elemento
;Resultado:'((y1 y2))
(cadr '((x1 x2) (y1 y2)))
;Devuelve el primer elemento de una lista que contiene todo excepto el primer elemento
;Resultado:'(y1 y2)
(pair? (car '(a short list)))
;car devuelve el primer elemento de la lista es decir 'a y pair? retorna true si el argumento es una lista no vacia que al ser a un elemento no es una lista, se retorna false
;Resultado: #f
(memq 'red '((red shoes) (blue socks)))
;memq busca la primera aparicion de red en la lista pero al ser esta formada por listas y no el elemento red de por si por lo que se retorna false(red forma parte de una sublista no de la lista)
;Resultado; #f
(memq 'red '(red shoes blue socks))
;En este caso se encuentra red en la lista por lo que se retorna la lista en la que aparece
;Resultado:'(red shoes blue socks)