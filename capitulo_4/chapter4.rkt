#lang racket/base

(require racket/function) ; Import required functions

; meta.rkt
; The metacircular evaluator from section 4.1

(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp) ; Primitive just "are". Return back
        ((symbol? exp) (or (hash-ref environ exp #f)
                           (error (string-append "Undefined symbol: " (symbol->string exp)))))
        ((define? exp) (seval-define exp environ))
        ((if? exp) (seval-if exp environ))
        ((quote? exp) (seval-quote exp environ))
        ((cond? exp) (seval-cond exp environ))
        ((let? exp) (seval-let exp environ))
        ((delay? exp) (seval-delay exp environ))
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
(for-each (lambda (op)
            (hash-set! environ op (eval op (make-base-namespace)))) ; Evaluate op directly
          '(+ - * / < > = <= >=)) ; Use eval directly

; Add primitives manually for testing
(hash-set! environ 'foo 123)

(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (procedure-application? exp)
  (list? exp))

; (define name value)
(define (define? exp)
  (and (list? exp) (eq? (car exp) 'define)))

; Selectors to extract information from the expression
(define (define-name exp)
  (cadr exp))

(define (define-value exp)
  (caddr exp))

; Evaluation
(define (seval-define exp environ)
  (let ((name (define-name exp))
        (value (define-value exp)))
    (define-in-environment! name (seval value environ) environ)))

(define (define-in-environment! name value environ)
  (hash-set! environ name value))

(define (quote? exp)
  (and (list? exp) (eq? (car exp) 'quote)))

(define (quote-expression exp)
  (cadr exp))

(define (seval-quote exp environ)
  (quote-expression exp))

; (if test consequence alternative)
(define (if? exp)
  (and (list? exp) (eq? (car exp) 'if)))

; Selectors
(define (if-test exp)
  (cadr exp))

(define (if-consequence exp)
  (caddr exp))

(define (if-alternative exp)
  (cadddr exp))

; How to evaluate if expressions
(define (seval-if exp environ)
  (if (seval (if-test exp) environ) ; Evaluate the test first
      (seval (if-consequence exp) environ)
      (seval (if-alternative exp) environ)))

; (begin exp1 ... expn)
; Evaluate all expressions
(define (begin? exp)
  (and (list? exp) (eq? (car exp) 'begin)))

(define (begin-expressions exp)
  (cdr exp)) ; Note: this returns a *list* of the expressions

(define (seval-begin exp environ)
  (let loop ([exps (begin-expressions exp)])
    (if (null? (cdr exps))
        (seval (car exps) environ)
        (begin (seval (car exps) environ)
               (loop (cdr exps))))))

(define (lambda? exp)
  (and (list? exp) (eq? (car exp) 'lambda)))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (caddr exp))

(define (make-procedure parameters body environ)
  (lambda args
    (let ((new-env (extend-environment parameters args environ)))
      (seval body new-env))))

(define (extend-environment parameters args environ)
  (let ((new-env (hash-copy environ)))
    ; Add parameter-argument bindings to new-env
    (for-each (lambda (param arg)
                (hash-set! new-env param arg))
              parameters
              args)
    new-env))

; Add support for 'cond' expressions
(define (cond? exp)
  (and (list? exp) (eq? (car exp) 'cond)))

(define (cond-clauses exp)
  (cdr exp))

(define (seval-cond exp environ)
  (let loop ([clauses (cond-clauses exp)])
    (if (null? clauses)
        (error "No true clause in cond expression")
        (let* ((clause (car clauses))
               (test (car clause))
               (body (cadr clause)))
          (if (eq? test 'else)
              (seval body environ)
              (if (seval test environ)
                  (seval body environ)
                  (loop (cdr clauses))))))))

; Add support for 'let' expressions
(define (let? exp)
  (and (list? exp) (eq? (car exp) 'let)))

(define (let-bindings exp)
  (cadr exp))

(define (let-body exp)
  (caddr exp))

(define (seval-let exp environ)
  (let* ((bindings (let-bindings exp))
         (params (map car bindings))
         (args (map (lambda (binding) (seval (cadr binding) environ)) bindings))
         (body (let-body exp))
         (new-env (extend-environment params args environ)))
    (seval body new-env)))

; Add support for 'delay' expressions
(define (delay? exp)
  (and (list? exp) (eq? (car exp) 'delay)))

(define (delay-expression exp)
  (cadr exp))

(define (seval-delay exp environ)
  (let ((expr (delay-expression exp)))
    (lambda () (seval expr environ))))

; Test framework
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

; Procedures
(seval '(define square (lambda (x) (* x x))) environ)
(check-equal? (seval '(square 4) environ) 16 "square failed")

(seval '(define fact (lambda (n) (if (= n 0) 1 (* n (fact (- n 1)))))) environ)
(check-equal? (seval '(fact 5) environ) 120 "fact failed")



;;Tests extra:
(check-equal? (seval '(if (< 3 2) (/ 1 0) 1) environ) 1 "if-false failed")
(check-equal? (seval '(if (< 2 3) 1 (/ 1 0)) environ) 1 "if-true failed")
(check-equal? (seval '(if (< 3 2) (/ 1 0) 1) environ) 1 "if-false failed")
(check-equal? (seval '(if (< 2 3) 1 (/ 1 0)) environ) 1 "if-true failed")

;; Tests para expresiones 'cond' 
(check-equal? (seval '(cond ((> 2 3) 'greater)
                            ((< 2 3) 'less)
                            (else 'equal)) environ) 'less "cond test 1 failed")
(check-equal? (seval '(cond ((= 3 3) 'equal)
                            (else 'not-equal)) environ) 'equal "cond test 2 failed")
(check-equal? (seval '(cond ((> 3 4) 'a)
                            ((> 4 5) 'b)
                            (else 'c)) environ) 'c "cond else clause failed")

;; Tests para expresiones 'let'
(check-equal? (seval '(let ((x 2) (y 3)) (+ x y)) environ) 5 "let test 1 failed")
(check-equal? (seval '(let ((x 5)) (* x x)) environ) 25 "let test 2 failed")
(check-equal? (seval '(let ((a 1) (b 2))
                        (let ((c (+ a b)))
                          (* c c))) environ) 9 "nested let test failed")

;; Tests para expresiones 'delay'
(define delayed-exp (seval '(delay (* 2 3)) environ))
(check-equal? (delayed-exp) 6 "delay test 1 failed")
(define delayed-sum (seval '(delay (+ 5 7)) environ))
(check-equal? (delayed-sum) 12 "delay test 2 failed")






