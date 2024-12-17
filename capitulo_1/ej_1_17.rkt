#lang racket
(define (double a)
  (* a 2))
(define (halve b)
  (/ b 2))

(define (fast-mul-iter a b)
  (define (iter a b resultado)
    (cond ((= b 0) resultado)  ; devolver resultado cuando b es 0 
          ((even? b) (iter (double a) (halve b) resultado)) ; si b es par, dobla a y divide b por 2
          (else (iter a (- b 1) (+ resultado a))))) ; si b es impar, sumar "a" a resultado y resta 1 a b 
  (iter a b 0))  ; empezar con resultado igual a 0

(fast-mul-iter 5 7)
; b es impar => (iter a (- b 1) (+ resultado a)) => (iter 5 (- 7 1) (+ 0 5)) => (iter 5 6 5) => a=5 b=6 resultado=5
; b es par => (iter (double a) (halve b) resultado)) => (iter (double 5) (halve 6) 5)) => (iter (* 5 2) (/ 6 2) 5)) => (iter 10 3 5))=> a=10 b=3 resultado=5
; b es impar => (iter a (- b 1) (+ resultado a)) => (iter 10 (- 3 1) (+ 5 10)) => (iter 10 2 15) => a=10 b=2 resultado=15
; b es par => (iter (double a) (halve b) resultado)) => (iter (double 10) (halve 2) 15)) => (iter (* 10 2) (/ 2 2) 15)) => (iter 20 1 15))=> a=10 b=3 resultado=5
; b es impar => (iter a (- b 1) (+ resultado a)) => (iter 20 (- 1 1) (+ 15 20)) => (iter 20 0 35) => a=20 b=1 resultado=35
; b es 0 => devolvemos resultado =35



