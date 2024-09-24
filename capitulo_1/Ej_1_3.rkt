#lang racket
(define (alfa x y z) (cond ((and (> x z) (> y z)) (+ (* x x) (* y y))) ((and (> x y) (> z y)) (+ (* x x) (* z z))) ((and (> y x) (> z x)) (+ (* y y) (* z z)))))           