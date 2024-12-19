#lang racket

; meta.rkt
; The metacircular evaluator from section 4.1



(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp)                            ; Primitive just "are". Return back
        ((simbolo? exp) (lookup-variable-value exp environ))  ; Symbols? Look up in the environment.
        ((define? exp) (make-define exp))
        ((if? exp) (seval-if exp environ))
        ((quote? exp) (quote-expression exp))
        ; ((cond? exp) ...)
        ; ((let ...))
        ; ((delay...))
        ((begin? exp) (begin-expressions exp))
        ((lambda? exp) ((make-procedure 
          (lambda-parameters exp)
          (lambda-body exp)
          env)))
        ((procedure-application? exp) (apply (eval (operator exp) env)
                (list-of-values 
                 (operands exp) 
                 env)))
        (else (error "Error desconocido"))
        )
  )

;defining the environment
(define environ (make-hash))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '= =)
(hash-set! environ '* *)
(hash-set! environ '/ /)


;COMPROBACIONES

(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (simbolo? exp) (symbol? exp))

(define (define? exp)
  (and (list? exp) (eq? (car exp) 'define))
  )

(define (if? exp)
  (and (list? exp) (eq? (car exp) 'if)))

(define (quote? exp)
  (and (list? exp) (eq? (car exp) 'quote)))

(define (aplicacion-procedimiento? exp)
  (list? exp)
  )

(define (begin? exp)
  (and (list? exp) (eq? (car exp) 'begin))
  )

(define (lambda? exp) 
  (tagged-list? exp 'lambda))

;SIMBOLOS
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop 
              (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) 
                        (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env)) 


;DEFINE
(define (define-name exp)
  (cadr exp)
)

(define (define-value exp)
  (caddr exp)
  )

(define (make-define exp)
  define (define-name exp) (define-value exp)
  )

(define (seval-define exp environ)
  (let ((name (define-name exp))
        (value (define-value exp)))
    (define-in-environment! name (seval value environ) environ)
    )
  )

;QUOTE

(define (quote-expression exp)
  (cadr exp))

; Como evaluar el operador quote

(define (seval-quote exp environ)
  (quote-expression exp)
  )

;IF

(define (if-test exp)
  (cadr exp)
  )

(define (if-consequence exp)
  (caddr exp)
  )

(define (if-alternative exp)
  (cadddr exp)
  )

(define (seval-if exp environ)
  (if (seval (if-test exp) environ)        ;  Evaluate the test first
      (seval (if-consequence exp) environ)
      (seval (if-alternative exp) environ)
      )
  )

;BEGIN
; (begin exp1 ... expn)
; Evaluar todas las expresiones
(define (begin-expressions exp)
  (cdr exp)      ; Note: this returns a *list* of the expressions
  )

;LAMBDA
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

;PROCEDURE APLICATION
(define (procedure-application? exp)
  (list? exp)
  )


;PRUEBAS
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



