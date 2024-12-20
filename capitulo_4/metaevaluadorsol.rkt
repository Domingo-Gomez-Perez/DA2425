#lang racket

; meta.rkt
; The metacircular evaluator from section 4.1

(require rackunit)


(define (seval exp environ)
  (cond ((primitiva? exp) exp)                            ; Primitive just "are". Return back
        ((simbolo? exp) (lookup-variable-value exp environ)) ; Symbols? Look up in the environment.
        ((define? exp) (seval-define exp environ))         ; Manejar las definiciones.
        ((if? exp) (seval-if exp environ))                ; Manejar condicionales.
        ((quote? exp) (seval-quote exp environ))          ; Manejar `quote`.
        ; ((cond? exp) ...)
        ; ((let ...))
        ; ((delay...))
        ((begin? exp) (seval-begin exp environ))          ; Manejar bloques de expresiones.
        ((lambda? exp) (make-procedure exp environ))      ; Crear un procedimiento.
        ((procedure-application?? exp) 
         (apply (seval (operator exp) environ)
                (list-of-values 
                 (operands exp) 
                 environ)))
        (else (error "Error desconocido"))
        )
  )


; Es un simbolo?

(define (simbolo? exp)
  (symbol? exp))


; Obtener operandos, operador y lista de valores
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


; Buscar un símbolo en el ambiente de forma alternativa.
(define (lookup-variable-value var environ)
  (define (find-in-environment env)
    (cond ((hash-has-key? env var) (hash-ref env var))
          ((hash-has-key? env 'nuevo) (find-in-environment (hash-ref env 'nuevo)))
          (else (error "Variable no definida:" var))))
  (find-in-environment environ))




; Extender el ambiente con nuevos valores de forma alternativa.
(define (extend-environment params args environ)
  (if (not (and (list? params) (list? args)))
      (error "extend-environment: params y args deben ser listas" params args)
      (let ((new-env (foldl (lambda (pair env)
                             (hash-set! env (car pair) (cdr pair))
                             env)
                           (make-hash)
                           (map cons params args))))
        (hash-set! new-env 'nuevo environ)
        new-env)))


; Definir una variable en el ambiente.
(define (define-in-environment! name value environ)
  (hash-set! environ name value))

; Manejar bloques begin.
(define (seval-begin exp environ)
  (let loop ((exprs (begin-expressions exp)))
    (cond ((null? (cdr exprs)) (seval (car exprs) environ)) ; Última expresión.
          (else (seval (car exprs) environ) (loop (cdr exprs)))))) ; Evaluar y continuar.

; ¿Es un lambda?
(define (lambda? exp)
  (and (list? exp) (eq? (car exp) 'lambda)))

; Crear un procedimiento.
(define (make-procedure exp environ)
  (let ((params (cadr exp))
        (body (caddr exp)))
    (lambda (argumentos)
      (let ((new-env (extend-environment params (list argumentos) environ))) ; Empaqueta args como lista
        (seval body new-env)))))




;defining the environment
(define environ (make-hash))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '= =)
(hash-set! environ '* *)  ; Define multiplicacion
(hash-set! environ '< <)  ; Define menos que
(hash-set! environ 'foo 123) ; Define foo como 123

;seguir metiendo movidas, es tedioso
(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (procedure-application?? exp)
  (list? exp)
  )

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



