#lang racket

(require rackunit)

; meta.rkt
; The metacircular evaluator from section 4.1

(define (seval exp env)
  (cond ((primitive? exp) exp)                                                                                     ; Primitive just "are". Return back
        ((symbol? exp) (lookup-variable-value exp env))                                                            ; Symbol? Look up in the environment.
        ((define? exp) (seval-define exp env))                                                                 ; Define? Evaluate the define expression.
        ((if? exp)     (seval-if exp env))                                                                     ; If? Evaluate the if expression.
        ((quote? exp)  (seval-quote exp))                                                                    ; Quote? Evaluate the quote expression.
        ((cond? exp)   (seval (cond->if exp) env))                                                                                       ; Cond? Evaluate the cond expression.
;        ((let? exp)    (seval-let exp env))                                                                                        ; Let? Evaluate the let expression.
;        ((delay? exp)  (seval-delay exp env))                                                                                        ; Delay? Evaluate the delay expression.
        ((begin? exp)  (seval-begin (begin-actions exp) env))                                                                                        ; Begin? Evaluate the begin expression.
        ((lambda? exp) (make-procedure (lambda-parameters exp) (lambda-body exp) env))                         ; Lambda? Evaluate the lambda expression.
        ((procedure-application? exp) (seval-procedure (seval (operator exp) env) (list-of-values (operands exp) env)))                                                      ; Procedure application? Apply the procedure.
        (else (error "Error desconocido"))
  )
)

; Defining the environment
(define env (make-hash))
(hash-set! env '+ +)
(hash-set! env '- -)
(hash-set! env '* *)
(hash-set! env '/ /)
(hash-set! env 'modulo modulo)
(hash-set! env 'abs abs)
(hash-set! env 'expt expt)
(hash-set! env 'sqrt sqrt)
(hash-set! env 'max max)
(hash-set! env 'min min)
(hash-set! env 'apply apply)
(hash-set! env '= =)
(hash-set! env '< <)
(hash-set! env '> >)
(hash-set! env '<= <=)
(hash-set! env '>= >=)
(hash-set! env 'not not)
(hash-set! env 'boolean? boolean?)
(hash-set! env 'car car)
(hash-set! env 'cdr cdr)
(hash-set! env 'cons cons)
(hash-set! env 'list list)
(hash-set! env 'length length)
(hash-set! env 'append append)
(hash-set! env 'reverse reverse)
(hash-set! env 'list-ref list-ref)
(hash-set! env 'list-tail list-tail)
(hash-set! env 'null? null?)
(hash-set! env 'member member)
(hash-set! env 'map map)
(hash-set! env 'string? string?)
(hash-set! env 'string-length string-length)
(hash-set! env 'string-append string-append)
(hash-set! env 'substring substring)
(hash-set! env 'string->list string->list)
(hash-set! env 'list->string list->string)
(hash-set! env 'string=? string=?)
(hash-set! env 'symbol? symbol?)
(hash-set! env 'symbol->string symbol->string)
(hash-set! env 'string->symbol string->symbol)
(hash-set! env 'display display)
(hash-set! env 'newline newline)
(hash-set! env 'number? number?)
(hash-set! env 'integer? integer?)
(hash-set! env 'real? real?)
(hash-set! env 'exact? exact?)
(hash-set! env 'inexact? inexact?)
(hash-set! env 'pair? pair?)
(hash-set! env 'procedure? procedure?)
(hash-set! env 'eq? eq?)
(hash-set! env 'equal? equal?)
(hash-set! env 'vector? vector?)
(hash-set! env 'make-vector make-vector)
(hash-set! env 'vector-ref vector-ref)
(hash-set! env 'vector-set! vector-set!)
(hash-set! env 'vector-length vector-length)
(hash-set! env 'vector vector)
(hash-set! env 'vector->list vector->list)
(hash-set! env 'list->vector list->vector)
(hash-set! env 'vector-fill! vector-fill!)
(hash-set! env 'null null)
(hash-set! env 'zero? zero?)
(hash-set! env 'positive? positive?)
(hash-set! env 'negative? negative?)
(hash-set! env 'even? even?)
(hash-set! env 'odd? odd?)
(hash-set! env 'char? char?)
(hash-set! env 'char=? char=?)
(hash-set! env 'char<? char<?)
(hash-set! env 'char>? char>?)
(hash-set! env 'char<=? char<=?)
(hash-set! env 'char>=? char>=?)
(hash-set! env 'char->integer char->integer)
(hash-set! env 'integer->char integer->char)
(hash-set! env 'char-upcase char-upcase)
(hash-set! env 'char-downcase char-downcase)

(hash-set! env 'foo 123)




; -------- Primitive -----------

(define (primitive? exp)
  (or (number? exp) (boolean? exp)))


; ---------- Symbol ------------

(define (lookup-variable-value var env)
  (cond
    [(hash-has-key? env var) (hash-ref env var)]
    [(hash-has-key? env 'lambda-env) 
     (lookup-variable-value var (hash-ref env 'lambda-env))]
    [else (error "Unbound variable" var)]))

; (define (lookup-variable-value var env)
;   (define (env-loop env)
;     (define (scan vars vals)
;       (cond ((null? vars) (env-loop (enclosing-environment env)))
;             ((eq? var (car vars)) (car vals))
;             (else (scan (cdr vars) (cdr vals))))
;     )
; 
;     (if (eq? env the-empty-environment)
;         (error "Unbound variable" var)
;         (let ((frame (first-frame env))) 
;           (scan (frame-variables frame) (frame-values frame))))
;   )
; 
;   (env-loop env))



; ---------- Define ------------

(define (define? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp) (cddr exp))))

; Creator of an environment new element
(define (define-in-environment! name value environment)
  (hash-set! env name value))

; Seval of a define
(define (seval-define exp env)
  (define-in-environment! (definition-variable exp) (seval (definition-value exp) env) env))  

; Borrar
;(define (seval-define exp env)
;  (define-variable! (definition-variable exp) (seval (definition-value exp) env) env))
;
; (define (define-variable! var val env)
;   (let ((frame (first-frame env)))
;     (define (scan vars vals)
;       (cond ((null? vars) (add-binding-to-frame! var val frame))
;             ((eq? var (car vars)) (mcar vals val))
;             (else (scan (cdr vars) (cdr vals)))))
;     (scan (frame-variables frame) (frame-values frame))))





; ----------- If -------------

(define (if? exp)
  (tagged-list? exp 'if))

; Selector to extract the predicate from the expression
(define (if-predicate exp)
  (cadr exp))

; Selector to extract the consequent  from the expression
(define (if-consequent  exp)
  (caddr exp))

; Selector to extract the alternative from the expression
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

; Seval of an if statement
(define (seval-if exp env)
  (if (true? (seval (if-predicate exp) env))
      (seval (if-consequent exp) env)
      (seval (if-alternative exp) env)))


; Auxiliary method (used in `cond->if`)

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))





; ---------- Quote -----------

(define (quote? exp)
  (tagged-list? exp 'quote))  

(define (seval-quote exp)
  (cadr exp))


; Auxiliary method

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))




; ---------- Cond ------------
(define (cond? exp) 
  (tagged-list? exp 'cond))

(define (cond-clauses exp)
   (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) 
  (car clause))

(define (cond-actions clause) 
  (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses)) (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last: COND->IF" clauses))
            (make-if (cond-predicate first) (sequence->exp (cond-actions first)) (expand-clauses rest))))))



; ---------- Begin -----------

(define (begin? exp) 
  (tagged-list? exp 'begin))

(define (begin-actions exp)
   (cdr exp))

(define (last-exp? seq) 
    (null? (cdr seq)))

(define (first-exp seq) 
    (car seq))

(define (rest-exps seq)
   (cdr seq))

(define (seval-begin exps env)
  (cond ((last-exp? exps) (seval (first-exp exps) env))
        (else (seval (first-exp exps) env) (seval-begin (rest-exps exps) env))))



; Auxiliary methods (used in `cond->if`)

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))






; --------- Lambda ----------

(define (lambda? exp) 
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp)
   (cadr exp))

(define (lambda-body exp)
   (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))





; --------- Procedure-application ----------

(define (procedure-application? exp)
    (pair? exp))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (seval (first-operand exps) env)
            (list-of-values 
             (rest-operands exps) 
             env))))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))


(define (seval-procedure procedure arguments)
  (cond 
    [(primitive-procedure? procedure)
     (apply-primitive-procedure procedure arguments)]
    [(compound-procedure? procedure)
     (seval-begin 
      (procedure-body procedure)
      (extend-environment (procedure-parameters procedure)
                          arguments
                          (procedure-environment procedure)))]
    [else (error "Unknown procedure type: APPLY" procedure)]))

(define (primitive-procedure? proc)
  (procedure? proc))

(define (apply-primitive-procedure proc args)
  (apply proc args))



; Borrar
;(define (seval-procedure procedure arguments)
;  (cond ((primitive-procedure? procedure) (apply-primitive-procedure procedure arguments))
;        ((compound-procedure? procedure) (seval-begin (procedure-body procedure) (extend-environment (procedure-parameters procedure) arguments (procedure-environment procedure))))
;        (else (error "Unknown procedure type: APPLY" procedure))))
;(define (primitive-procedure? proc)
;  (tagged-list? proc 'primitive))
;(define (primitive-implementation proc) 
;  (cadr proc))
;(define (apply-primitive-procedure proc args)
;  (apply-in-underlying-scheme
;   (primitive-implementation proc) args))



(define apply-in-underlying-scheme apply)





(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())





(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (mcar frame (cons var (car frame)))
  (mcdr frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (let ((new-env (make-hash)))
        (for ([var vars] [val vals])
          (hash-set! new-env var val))
        (hash-set! new-env 'lambda-env base-env) ; Save parent env for lookup
        new-env)
      (error "Mismatched arguments and parameters"
             vars
             vals)))











; -------------- Testing predicates ------------------

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))

;(define (check-equal? actual expected message)
;  (if (equal? actual expected)
;      #t
 ;     (error message)))







; Varias pruebas para ver que es lo que tiene que ocurrir
(check-equal? (seval '42 env) 42 "Primitives failed")
(check-equal? (seval 'foo env) 123 "Symbol lookup failed")
(seval '(define x 42) env)
(check-equal? (seval 'x env) 42 "Simple define failed")
(seval '(define y (+ 2 3)) env)
(check-equal? (seval 'y env) 5 "Expression define failed")
(check-equal? (seval '(quote x) env) 'x "Quoting failed")

(check-equal? (seval '(if (< 2 3) 1 (/ 1 0)) env) 1 "if-true failed")
(check-equal? (seval '(if (< 3 2) (/ 1 0) 1) env) 1 "if-false failed")

; Procedures
(seval '(define square (lambda (x) (* x x))) env)
(check-equal? (seval '(square 4) env) 16 "square failed")

(seval '(define fact (lambda (n) (if (= n 0) 1 (* n (fact (- n 1)))))) env)
(check-equal? (seval '(fact 5) env) 120 "fact failed")