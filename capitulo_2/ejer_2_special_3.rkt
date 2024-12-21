#lang racket
(define (match list1 list2)
  (cond ((and (null? list1) (null? list2))  #t)
        ((or (null? list1) (null? list2))  #f)
        ((eq? (car list2) '?)  #t)
        ((and (pair? (car list1)) (pair? (car list2)))  (or (match (car list1) (car list2)) (match (cdr list1) (cdr list2))))
        ((eq? (car list1) (car list2))  (and #t (match (cdr list1) (cdr list2))))
        (else  #f)))

(define record '(job (Hacker Alyssa P) (computer programmer)))

(match '(job ? ?) record)           ; --> true
(match '(job ? (? coder)) record)   ; --> false
(match '(? ? (computer ?)) record)  ; --> true