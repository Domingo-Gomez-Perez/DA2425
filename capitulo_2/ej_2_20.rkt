#lang racket
;Exercise 2.20: The procedures +, *, and list take arbitrary numbers of arguments. One way to define such procedures is to use define with "dotted-tail notation".
;In a procedure definition, a parameter list that has a dot before the last parameter name indicates that, when the procedure is called,
;the initial parameters (if any) will have as values the initial arguments, as usual, but the final parameter's value will be a list of any remaining arguments.
;For instance, given the definition

;(define (f x y . z) ⟨body⟩)
;the procedure f can be called with two or more arguments. If we evaluate

;(f 1 2 3 4 5 6)
;then in the body of f, x will be 1, y will be 2, and z will be the list (3 4 5 6). Given the definition

;(define (g . w) ⟨body⟩)
;the procedure g can be called with zero or more arguments. If we evaluate

;(g 1 2 3 4 5 6)
;then in the body of g, w will be the list (1 2 3 4 5 6).

;Note: Dotted-tail notation is similar to the *args syntax in Python. For example:

;def f(x, y, *z):
    
;Use this notation to write a procedure same-parity that takes one or more integers and returns a list of all the arguments that have the same even-odd parity as the first argument. For example,

;(same-parity 1 2 3 4 5 6 7)
;(1 3 5 7)

;(same-parity 2 3 4 5 6 7)
;(2 4 6)
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))
;Hace f(1,2) = x f(x,3) = y

(define (appended seq1 seq2) (accumulate cons seq2 seq1))
(define (length sequence) (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define (even x) (= (remainder x 2) 0))
(define (odd x) (= (remainder x 2) 1))

(define (unepares resto total) ( if (null? resto) total ( if (even (car resto)) (unepares (cdr resto) (appended total (list (car resto)))) (unepares (cdr resto) total))
                          )
  )

(define (uneimpares resto total) ( if (= 0 (length resto)) total ( if (odd (car resto)) (uneimpares (cdr resto) (appended total (list (car resto)))) (uneimpares (cdr resto) total))
                          )
  )

(define (same-parity inicial . resto)
     (if (even inicial) (appended (list inicial) (unepares resto '())) (appended (list inicial) (uneimpares resto '())))
  )

(same-parity 1 2 3 4 5)

(same-parity 2 3 4 5 6)