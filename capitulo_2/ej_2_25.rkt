#lang racket

;(1 3 (5 7) 9)
(define x
  (list 1 3 (list 5 7) 9))
(car (cdaddr x))

;((7))
(define y
  (list (list 7)))
(caar y)

;(1 (2 (3 (4 (5 (6 7))))))
(define z
  (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr z))))))))))))