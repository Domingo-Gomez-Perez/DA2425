#lang racket

; Exercise 2.25

; Give combinations of `car` and `cdr` that will pick 7
; from each of the following lists:

; (1 3 (5 7) 9)
(define lst-1 (list 1 3 (list 5 7) 9))
(car (cdaddr lst-1))


; ((7))
(define lst-2 (list (list 7)))
(caar lst-2)


; (1 (2 (3 (4 (5 (6 7))))))
(define lst-3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(cadadr (cadadr (cadadr lst-3)))


; In order to simplify my implementation, I used the reduced
; version of `car` and `cdr` concatenating  `d` and `a` between
; `c<???>r`. We can perform the same action.

; Example:
; (cadar x) ->  (car (cdr (car x)))

; (There might be a limit of 5 characters per instruction)