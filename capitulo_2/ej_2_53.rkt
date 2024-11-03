#lang racket

; Exercise 2.53

; What would the interpreter print in response to 
; evaluating each of the following expressions?

(list 'a 'b 'c)                          ; Should return '(a b c)
(list (list 'george))                    ; Should return '((george))
(cdr '((x1 x2) (y1 y2)))                 ; Should return '((y1 y2))
(cadr '((x1 x2) (y1 y2)))                ; Should return '(y1 y2)
(pair? (car '(a short list)))            ; Should return #f
(memq 'red '((red shoes) (blue socks)))  ; Should return #f
(memq 'red '(red shoes blue socks))      ; Should return '(red shoes blue socks)