#lang racket

; meta.rkt
; The metacircular evaluator from section 4.1

(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp)                            ; Primitive just "are". Return back
        ((symbol? exp) (lookup-variable-value exp environ))  ; Symbols? Look up in the environment.
        ((define? exp) (begin (define-name exp) (define-value exp)))
        ((if? exp) ???)
        ((quote? exp) ???)
        ; ((cond? exp) ...)
        ; ((let ...))
        ; ((delay...))
        ((begin? exp) ???)
        ((lambda? exp) ???)
        ((procedure-application? exp) ???)
        (else (error "Error desconocido"))
        )
  )

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

;defining the environment
(define environ (make-hash))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '= =)
(hash-set! environ '* *)
(hash-set! environ '/ /)

;seguir metiendo movidas, es tedioso

(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (procedure-application? exp)
  (list? exp)
  )

(define (make-if predicate 
                 consequent 
                 alternative)
  (list 'if 
        predicate 
        consequent 
        alternative))

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

; (define name value)

; Predicate to test
(define (define? exp)
  (and (list? exp) (eq? (car exp) 'define))
  )

; Selectors to extract information from the expression
(define (define-name exp)
  (cadr exp)
)

(define (define-value exp)
  (caddr exp)
  )

; Evaluacion
(define (seval-define exp environ)
  (let ((name (define-name exp))
        (value (define-value exp)))
    (define-in-environment! name (seval value environ) environ)
    )
  )



(define (quote? exp)
  (and (list? exp) (eq? (car exp) 'quote)))

(define (quote-expression exp)
  (cadr exp))

; Como evaluar el operador quote

(define (seval-quote exp environ)
  (quote-expression exp)
  )

; (if test consequence alternative)

(define (if? exp)
  (and (list? exp) (eq? (car exp) 'if)))

; Selectors
(define (if-test exp)
  (cadr exp)
  )

(define (if-consequence exp)
  (caddr exp)
  )

(define (if-alternative exp)
  (cadddr exp)
  )

; como evaluar los if
(define (seval-if exp environ)
  (if (seval (if-test exp) environ)        ;  Evaluate the test first
      (seval (if-consequence exp) environ)
      (seval (if-alternative exp) environ)
      )
  )

; (begin exp1 ... expn)
; Evaluar todas las expresiones

(define (begin? exp)
  (and (list? exp) (eq? (car exp) 'begin))
  )

(define (begin-expressions exp)
  (cdr exp)      ; Note: this returns a *list* of the expressions
  )


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



