#lang racket

;En cada caso printara cosas diferentes.
(list 'a 'b 'c); Printa una lista con a b c
(list (list 'george)); Printa una lista de a b c dentro de otra lista
(cdr '((x1 x2) (y1 y2))); Printa el resto de la lista quirando el 1 elemento ((x1 x2) (y1 y2))
                        ; Que sería ((y1 y2))

(cadr '((x1 x2) (y1 y2))); Printa el segundo valor cogiendo el elemento (y1 y2)
(pair? (car '(a short list))); Falso no se encuentra en ninguna
(memq 'red '((red shoes) (blue socks))); Falso puesto que no esta en la lista sino en la sublitas
; y por lo tanto no lo detecta
(memq 'red '(red shoes blue socks));Printa todo puesto que devuelve desde red hasta el final,
;es decir, (red shoes blue socks)