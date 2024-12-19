#lang racket

; meta.rkt
; The metacircular evaluator from section 4.1

(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp)                            ; Primitive just "are". Return back
        ((simbolo? exp) (lookup-in-enviroment exp environ))  ; Symbols? Look up in the environment.
        ((define? exp) (seval-define exp environ))
        ((if? exp) (seval-if exp environ))
        ((quote? exp) (seval-quote exp environ))
        ; ((cond? exp) ...)
        ; ((let ...))
        ; ((delay...))
        ((begin? exp) (seval-begin exp environ))
        ((lambda? exp) (seval-lambda exp environ))
        ((procedure-application? exp) (apply-procedure
                                       (seval (car exp-environ));Operador
                                       (map (lambda (arg)(seval arg environ))
                                            (cdr exp))));Argumentos
                                       
                                       
        (else (error "Error desconocido"))
        
  ))

;defining the environment
(define environ (make-hash))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '= =)
(hash-set! environ '* *)
(hash-set! environ '/ /)
(hash-set! environ '> >)
(hash-set! environ '< <)

;seguir metiendo movidas, es tedioso
(define (lookup-in-enviroment v environ)
  (hash-ref environ var (lambda() (error "Variable no definida: "v)))
  )

(define (define-in-enviroment! nombre valor environ)
  (hash-set! environ nombre valor)
  )

(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (aplicacion-procedimiento? exp)
  (list? exp)
  )

(define (simbolo? exp)
  (sybol? expr))



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
; Evaluar begin
(define (seval-begin exp environ)
  (let ((expr (begin-expr exp)))
    (fold1
     (lambda (e_last)(serval e environ)
       #f
       expr)

     )))
;Evaluar lambda
(define (seval-lambda exp environ)
  (let ((params (lambda-parametres exp))
        (body (lambda-body exp)))
    (make-procedure params body environ)))
    
(define (lambda? exp)
  (and (list? exp)
       (eq? (car exp) 'lambda)
       (list? (cadr exp))
       )

  )
;Evaluar procidimientos
(define (procedure-application? exp)
  (and (list? exp)
       (not (null? exp))
       (list? (cdr exp)))
  )


(define (apply-procedure proc args)
  (cond
  ((procedure? proc)
   (apply proc (map(lambda (arg) (seval arg environ))args)))

  ((and (pair? proc) (eq? (car proc) 'lambda))
  (aplica-lambda proc args))

  (else(error "Aplicación de proc fallida"))

   )
  )

(define (aplica-lambda proc args)
  (let* ((params (cadr proc))
         (body (cddr proc))
         (new-environ (extend-environment params args environ)))
    (seval body new-environ))) 
         
  





  
 
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



