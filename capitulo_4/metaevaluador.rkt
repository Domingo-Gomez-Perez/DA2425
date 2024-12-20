#lang racket

; meta.rkt
; The metacircular evaluator from section 4.1

(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp)                             ; Primitive just "are". Return back
        ((symbol? exp) (lookup exp environ))               ; Symbols: look up in the environment
        ((define? exp) (seval-define exp environ))         ; Define statements
        ((if? exp) (seval-if exp environ))                 ; If expressions
        ((quote? exp) (seval-quote exp environ))           ; Quoting
        ((begin? exp) (seval-begin exp environ))           ; Begin blocks
        ((lambda? exp) (make-procedure exp environ))       ; Lambda expressions
        ((procedure-application? exp) (apply-procedure exp environ)) ; Procedure application
        (else (error "Unknown expression type" exp))))

; Environment implementation
(define (make-environment)
  (make-hash))

(define (lookup var environ)
  (if (hash-has-key? environ var)
      (hash-ref environ var)
      (error "Variable not found in environment" var)))

(define (define-in-environment! name value environ)
  (hash-set! environ name value))

; Predicates and selectors
(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (define? exp)
  (and (list? exp) (eq? (car exp) 'define)))

(define (define-name exp)
  (cadr exp))

(define (define-value exp)
  (caddr exp))

(define (if? exp)
  (and (list? exp) (eq? (car exp) 'if)))

(define (if-test exp)
  (cadr exp))

(define (if-consequence exp)
  (caddr exp))

(define (if-alternative exp)
  (cadddr exp))

(define (quote? exp)
  (and (list? exp) (eq? (car exp) 'quote)))

(define (quote-expression exp)
  (cadr exp))

(define (begin? exp)
  (and (list? exp) (eq? (car exp) 'begin)))

(define (begin-expressions exp)
  (cdr exp))

(define (lambda? exp)
  (and (list? exp) (eq? (car exp) 'lambda)))

(define (procedure-application? exp)
  (list? exp))

; Evaluators for specific constructs
(define (seval-define exp environ)
  (let ((name (define-name exp))
        (value (define-value exp)))
    (define-in-environment! name (seval value environ) environ)
    name))

(define (seval-quote exp environ)
  (quote-expression exp))

(define (seval-if exp environ)
  (if (seval (if-test exp) environ)
      (seval (if-consequence exp) environ)
      (seval (if-alternative exp) environ)))

(define (seval-begin exp environ)
  (define (eval-sequence exps environ)
    (if (null? (cdr exps))
        (seval (car exps) environ)
        (begin (seval (car exps) environ)
               (eval-sequence (cdr exps) environ))))
  (eval-sequence (begin-expressions exp) environ))

; Procedure application
(define (make-procedure exp environ)
  (list 'procedure (cadr exp) (cddr exp) environ))

(define (procedure-parameters proc)
  (cadr proc))

(define (procedure-body proc)
  (caddr proc))

(define (procedure-environment proc)
  (cadddr proc))

(define (apply-procedure exp environ)
  (let* ((proc (seval (car exp) environ))
         (args (map (lambda (e) (seval e environ)) (cdr exp))))
    (cond
      ((and (list? proc) (eq? (car proc) 'procedure)) ; User-defined procedure
       (let ((new-env (extend-environment (procedure-parameters proc) args
                                          (procedure-environment proc))))
         (seval-begin (cons 'begin (procedure-body proc)) new-env)))
      ((procedure? proc) ; Built-in procedure
       (apply proc args))
      (else (error "Unknown procedure type" proc)))))

; Extend environment with parameters and arguments
(define (extend-environment params args parent-env)
  (let ((new-env (hash-copy parent-env)))
    (for-each (lambda (param arg)
                (define-in-environment! param arg new-env))
              params args)
    new-env))

(define (check-equal? actual expected message)
  (if (equal? actual expected)
      #t
      (error message)))

; Testing the evaluator
(define environ (make-environment))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '* *)
(hash-set! environ '/ /)
(hash-set! environ '< <)
(hash-set! environ '= =)
(hash-set! environ 'foo 123)

;; Varias pruebas para ver que es lo que tiene que ocurrir
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
