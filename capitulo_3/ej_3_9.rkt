#lang racket
;Exercise 3.9: Will discuss as a group. In 1.2.1 we used the substitution model to analyze two procedures for computing factorials, a recursive version

;(define (factorial n)
;  (if (= n 1)
;      1
;      (* n (factorial (- n 1)))))
;and an iterative version

;(define (factorial n)
;  (fact-iter 1 1 n))

;(define (fact-iter product 
;                   counter 
;                   max-count)
;  (if (> counter max-count)
;      product
;      (fact-iter (* counter product)
;                 (+ counter 1)
;                 max-count)))
;Show the environment structures created by evaluating (factorial 6) using each version of the factorial procedure.

;Primera version

;Al llamar a factorial 6 se crea un objeto nuevo, con codigo y ambiente n = 6, al llamar a factorial 5 se crea un ambiente dentro de este, y asi sucesivamente
;---------------------
;|  Global           |
;---------------------
;          |
;          v
;|---------------------------|
;| factorial n = 6           |
;||-------------------------||
;|| factorial n = 5         ||
;|||-----------------------|||
;||| factorial n = 4       |||
;||||---------------------||||
;|||| factorial n = 3     ||||
;|||||-------------------|||||
;||||| factorial  n = 2  |||||
;||||||-----------------||||||
;|||||| factorial n = 1 ||||||
;||||||-----------------||||||
;|||||-------------------|||||
;||||---------------------||||
;|||-----------------------|||
;||-------------------------||
;|---------------------------|
;(factorial 6)
;(* 6 (factorial 5))
;(* 6 ( * 5 (factorial 4)))
;(* 6 ( * 5 (* 4 (factorial 3))))
;(* 6 ( * 5 (* 4 (* 3 (factorial 2)))))
;(* 6 ( * 5 (* 4 (* 3 (* 2 (factorial 1))))))
;(* 6 ( * 5 (* 4 (* 3 (* 2 1)))))
;(* 6 ( * 5 (* 4 (* 3 2))))
;(* 6 ( * 5 (* 4 6)))
;(* 6 ( * 5 24))
;(* 6 120)
;720
;Al ser recursivo se guardan n digitos o funciones como maximo

;Segunda version
;Al llamar a factorial 6 se crea un objeto nuevo, con codigo y ambiente n = 6,
;llama a fact-iter con ambiente product = 1, counter = 1, max-count = 6, se crea un nuevo ambiente fuera de este al que se le pasan los nuevos datosy asi sucesivamente.
;product = 1, counter = 2, max-count = 6,
;---------------------
;|  Global           |
;---------------------
;          |
;          v
;|-----------------------------|
;| factorial n = 1, total = 1  |
;|-----------------------------|
;          |
;          v
;|-----------------------------|
;| factorial n = 2, total = 1  |
;|-----------------------------|
;          |
;          v
;|-----------------------------|
;| factorial n = 3, total = 2  |
;|-----------------------------|
;          |
;          v
;|-----------------------------|
;| factorial n = 4, total = 6  |
;|-----------------------------|
;          |
;          v
;|-----------------------------|
;| factorial n = 5, total = 24 |
;|-----------------------------|
;          |
;          v
;|-----------------------------|
;| factorial n = 6, total = 120|
;|-----------------------------|
;          |
;          v
;|-----------------------------|
;| factorial n = 7, total = 720|
;|-----------------------------|
;(factorial 6)
;(fact-iter 1 1 6)
;(fact-iter 1 2 6)
;(fact-iter 2 3 6)
;(fact-iter 6 4 6)
;(fact-iter 24 5 6)
;(fact-iter 120 6 6)
;(fact-iter 720 7 6)
;720
;Al ser iterativo solo se guarda la llamada recursiva o el digito final como maximo