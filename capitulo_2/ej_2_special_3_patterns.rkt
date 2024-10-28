#lang racket

; Special Exercise (Patterns)

; Sometimes it's useful to match patterns in data. For example, consider this record:

(define record '(job (Hacker Alyssa P) (computer programmer)))

; Write a procedure `(match pattern data)` that matches structure:

 (define (match pattern data)
  (cond
    ((and (null? pattern) (null? data)) #t)
    ((not (pair? pattern)) (or (eq? pattern data) (eq? pattern '?)))
    ((eq? (car pattern) '?) (match (cdr pattern) (cdr data)))
    ((and (pair? (car pattern)) (pair? (car data))) (and (match (car pattern) (car data)) (match (cdr pattern) (cdr data))))
    ((eq? (car pattern) (car data)) (match (cdr pattern) (cdr data)))
    (else #f)))


(match '(job ? ?) record)                         ; Should return #t
(match '(? ? (computer ?)) record)                ; Should return #t
(match '(job (Hacker ? P) (computer ?)) record)   ; Should return #t
(match '? record)                                 ; Should return #t

(match '(job (() ? P) (computer ?)) record)       ; Should return #f
(match '(job ? (? coder)) record)                 ; Should return #f