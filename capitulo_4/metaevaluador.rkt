#lang racket

(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp) ; Primitive just "are". Return back
        ((symbol? exp) (or (hash-ref environ exp #f)
                           (error (string-append "Undefined symbol: " (symbol->string exp)))))
        ((define? exp) (seval-define exp environ))
        ((if? exp) (seval-if exp environ))
        ((quote? exp) (seval-quote exp environ))
        ((begin? exp) (seval-begin exp environ))
        ((lambda? exp) (make-procedure (lambda-parameters exp) (lambda-body exp) environ))
        ((procedure-application? exp)
         (let ((proc (seval (car exp) environ))
               (args (map (lambda (e) (seval e environ)) (cdr exp))))
           (if (procedure? proc)
               (apply proc args)
               (error "Not a procedure: " (format "~a" (car exp))))))
        (else (error "Unknown expression type"))))

; Define the initial environment
(define environ (make-hash))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '= =)
(hash-set! environ '* *)
(hash-set! environ '/ /)
(hash-set! environ '> >)
(hash-set! environ '< <)
(hash-set! environ '>= >=)
(hash-set! environ '<= <=)

; Primitivas
(hash-set! environ 'foo 123)

(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (procedure-application? exp)
  (list? exp))

; Define
(define (define? exp)
  (and (list? exp) (eq? (car exp) 'define)))
(define (define-name exp)
  (cadr exp))
(define (define-value exp)
  (caddr exp))
(define (seval-define exp environ)
  (let ((name (define-name exp))
        (value (define-value exp)))
    (define-in-environment! name (seval value environ) environ)))

(define (define-in-environment! name value environ)
  (hash-set! environ name value))

; Quote
(define (quote? exp)
  (and (list? exp) (eq? (car exp) 'quote)))

(define (quote-expression exp)
  (cadr exp))

(define (seval-quote exp environ)
  (quote-expression exp))

; If
(define (if? exp)
  (and (list? exp) (eq? (car exp) 'if)))

(define (if-test exp)
  (cadr exp))

(define (if-consequence exp)
  (caddr exp))

(define (if-alternative exp)
  (cadddr exp))

(define (seval-if exp environ)
  (if (seval (if-test exp) environ) ; Evaluate the test first
      (seval (if-consequence exp) environ)
      (seval (if-alternative exp) environ)))

; Begin
(define (begin? exp)
  (and (list? exp) (eq? (car exp) 'begin)))

(define (begin-expressions exp)
  (cdr exp))

(define (seval-begin exp environ)
  (let loop ([exps (begin-expressions exp)])
    (if (null? (cdr exps))
        (seval (car exps) environ)
        (begin (seval (car exps) environ)
               (loop (cdr exps))))))
; Lambda
(define (lambda? exp)
  (and (list? exp) (eq? (car exp) 'lambda)))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (caddr exp))

; Make-Procedure
(define (make-procedure parameters body environ)
  (lambda args
    (let ((new-env (extend-environment parameters args environ)))
      (seval body new-env))))

; Extend-Enviroment
(define (extend-environment parameters args environ)
  (let ((new-env (hash-copy environ)))
    (for-each (lambda (param arg)
                (hash-set! new-env param arg))
              parameters
              args)
    new-env))

; Check-Equal para comprobar resultados correctos
(define (check-equal? actual expected message)
  (if (equal? actual expected)
      #t
      (error message)))

;; Tests
(check-equal? (seval '42 environ) 42 "Primitives failed")
(check-equal? (seval 'foo environ) 123 "Symbol lookup failed")
(seval '(define x 42) environ)
(check-equal? (seval 'x environ) 42 "Simple define failed")
(seval '(define y (+ 2 3)) environ)
(check-equal? (seval 'y environ) 5 "Expression define failed")
(check-equal? (seval '(quote x) environ) 'x "Quoting failed")

(check-equal? (seval '(if (< 2 3) 1 (/ 1 0)) environ) 1 "if-true failed")
(check-equal? (seval '(if (< 3 2) (/ 1 0) 1) environ) 1 "if-false failed")

; If Test
(check-equal? (seval '(if (= 2 2) 100 200) environ) 100 "if test equality")
(check-equal? (seval '(if (> 3 2) (+ 2 3) (- 3 2)) environ) 5 "if true branch")
(check-equal? (seval '(if (< 3 2) (+ 2 3) (- 3 2)) environ) 1 "if false branch")
(check-equal? (seval '(if (= 1 2) 42 0) environ) 0 "if test false branch")

; Begin Test
(check-equal? (seval '(begin (define a 10) (+ a 5)) environ) 15 "begin test")
(check-equal? (seval '(begin (define b (+ 2 3)) (* b 2)) environ) 10 "begin with expression")
(check-equal? (seval '(begin (define c 10) (define d 20) (+ c d)) environ) 30 "begin with multiple defines")

; Define Test
(seval '(define a 100) environ)
(check-equal? (seval 'a environ) 100 "define variable a")
(seval '(define b (+ 1 1)) environ)
(check-equal? (seval 'b environ) 2 "define expression b")

; Lambda Test (funciones anónimas)
(seval '(define inc (lambda (x) (+ x 1))) environ)
(check-equal? (seval '(inc 5) environ) 6 "lambda function inc")
(seval '(define add (lambda (x y) (+ x y))) environ)
(check-equal? (seval '(add 5 10) environ) 15 "lambda function add")

; Procedure Application Test 
(seval '(define mul (lambda (x y) (* x y))) environ)
(check-equal? (seval '(mul 5 10) environ) 50 "procedure application mul")
(seval '(define div (lambda (x y) (/ x y))) environ)
(check-equal? (seval '(div 20 4) environ) 5 "procedure application div")
(seval '(define square (lambda (x) (* x x))) environ)
(check-equal? (seval '(square 4) environ) 16 "square failed")

(seval '(define fact (lambda (n) (if (= n 0) 1 (* n (fact (- n 1)))))) environ)
(check-equal? (seval '(fact 5) environ) 120 "fact failed")

