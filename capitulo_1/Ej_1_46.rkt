#lang racket
; Ejercicio 1.46

(define (average x y) (/ (+ x y) 2))

(define (sqrt-rec x guess limit) (
    if (= 15 limit)
       guess
       (sqrt-rec x (average guess (/ x guess)) (+ limit 1))
                            ))

(define (sqrt x) (
    sqrt-rec x 1 1
                  ))

(define tolerance 0.1)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs v1 v2) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (abs x y) (
    if (> (- x y) 0)
       (- x y)
       (- y x)
                   ))

(define (sqrt-guessGood? guess lastGuess) (
    if (< (abs lastGuess guess) tolerance)
       #t
       #f
                                 ))

(define (sqrt-improveGuess guess original) (
    average guess (/ original guess)
                                   ))

(define (f x) (* x x))

(define (fpgood? guess lastGuess) (
    < (abs guess lastGuess) tolerance
                                   ))

(define (fpimprove guess original) (
    f guess
                                    ))

(define (iterative-improve f g) (
    lambda (lastGuess guess original) (
        if (f guess lastGuess)
           guess
           ((iterative-improve f g) guess (g guess original) original)
                )
                                      ))

; sqrt super aproximada vs la version de iterative-improve
(sqrt 2)
((iterative-improve sqrt-guessGood? sqrt-improveGuess) 1 (sqrt-improveGuess 1 2) 2)

; fixed-point original vs la version iterative-improve
(fixed-point f 1)
((iterative-improve fpgood? fpimprove) 2 (fpimprove 2 1) 1)
