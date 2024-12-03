#lang racket

(list 'a 'b 'c) ; Devolvera una lista de simbolos '(a b c)
(list (list 'george)) ; Devolvera una lista que contiene otra lista, en este caso '((george))
(cdr '((x1 x2) (y1 y2))) ; Devolvera la lista menos el primer elemento de esta (en este caso (x1 x2)). por lo que devolvera '((y1 y2)) 
(cadr '((x1 x2) (y1 y2))) ; La diferencia con el anterior es que nos devuelve toda la lista menos el primer elemento y luego nos devuelve el primer elemento
                          ; De la lista "nueva" por lo que obtendremos '(y1 y2)
(pair? (car '(a short list))) ; pair? nos dice si un argumento es un par (una lista no vacia), en este caso el argumento va a ser 'a que no lo es por lo que
                              ; devolvera #f
(memq 'red '((red shoes) (blue socks))) ; memq devuelve una sublista que comienza desde la posicion del simbolo que le entra como argumento, sin embargo, como
                                        ; el argumento se encuentra en una subilsta, no en la lista principal devuelve #f
(memq 'red '(red shoes blue socks)) ; En este caso memq si que encuentra en la lista principal el argumento 'red por lo que devuelve una sublista empezando por
                                    ; 'red. Devolvera '(red shoes blue socks)