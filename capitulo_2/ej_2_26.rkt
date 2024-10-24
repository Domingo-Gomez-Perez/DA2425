#lang racket

; Exercise 2.26

; Suppose we define `x` and `y` to be two lists:

(define x (list 1 2 3))
(define y (list 4 5 6))

; What result is printed by the interpreter in response
; to evaluating each of the following expressions:

; `append` takes two lists and adds each element of
; the second list to the first one
(append x y)

; `cons` takes one element and a list, and it adds the element
; to the list. In this case, it add a list into another
(cons x y)

; `list` takes two elements and create a list with theese two
; elements. In this case, it creates a list of two lists.
(list x y)