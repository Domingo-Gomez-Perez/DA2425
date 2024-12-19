#lang racket

(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp)                           
        ((symbol? exp) (or (hash-ref environ exp #f)
                          (error (string-append "Undefined symbol: " (symbol->string exp)))))
        ((define? exp) (seval-define exp environ))
        ((if? exp) (seval-if exp environ))
        ((quote? exp) (seval-quote exp environ))
        ((cond? exp) (seval-cond exp environ))
        ((let? exp) (seval-let exp environ))
        ((delay? exp) (seval-delay exp environ))
        ((begin? exp) (seval-begin exp environ))
        ((lambda? exp)
         (make-procedure 
          (lambda-parameters exp)
          (lambda-body exp)
          environ))
        ((procedure-application? exp)
         (let ((proc (seval (car exp) environ))
               (args (map (lambda (e) (seval e environ)) (cdr exp))))
           (if (procedure? proc)
               (apply proc args)
               (error "Not a procedure: " (format "~a" (car exp))))))
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
(hash-set! environ '> >)
(hash-set! environ '< <)
(hash-set! environ '>= >=)
(hash-set! environ '<= <=)


; Comprobar etiquetas en expresiones
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

; Primitivas (números, booleanos)
(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

; Verificar si una expresión es una aplicación de procedimiento
(define (procedure-application? exp) (list? exp))


; Verificar si una expresión es una definición
(define (define? exp) (and (list? exp) (eq? (car exp) 'define)))
(define (define-name exp) (cadr exp))
(define (define-value exp) (caddr exp))
(define (seval-define exp environ)
  (let ((name (define-name exp))
        (value (define-value exp)))
    (hash-set! environ name (seval value environ))))

; Quote
(define (quote? exp) (and (list? exp) (eq? (car exp) 'quote)))
(define (quote-expression exp) (cadr exp))
(define (seval-quote exp environ) (quote-expression exp))

; If
(define (if? exp) (and (list? exp) (eq? (car exp) 'if)))
(define (if-test exp) (cadr exp))
(define (if-consequence exp) (caddr exp))
(define (if-alternative exp) (cadddr exp))
(define (seval-if exp environ)
  (if (seval (if-test exp) environ)
      (seval (if-consequence exp) environ)
      (seval (if-alternative exp) environ)))


;BEGIN

(define (seval-begin exp environ)
  (begin-expression exp))

(define (begin? exp) 
  (tagged-list? exp 'begin))

(define (begin-expression exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))

;LAMBDA

(define (lambda? exp) 
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (caddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;MAKE-PROCEDURE

(define (make-procedure parameters body environ)
  (lambda args
    (let ((new-env (extend-environment parameters args environ)))
      (seval body new-env))))

;EXTEND-ENV

(define (extend-environment parameters args environ)
  (let ((new-env (hash-copy environ)))
    (for-each (lambda (param arg)
                (hash-set! new-env param arg))
              parameters
              args)
    new-env))

;COND

(define (cond? exp) (and (list? exp) (eq? (car exp) 'cond)))
(define (cond-clauses exp) (cdr exp))
(define (seval-cond exp environ)
  (let loop ([clauses (cond-clauses exp)])
    (if (null? clauses)
        (error "Ninguna cláusula verdadera en cond")
        (let* ((clause (car clauses))
               (test (car clause))
               (body (cadr clause)))
          (if (eq? test 'else)
              (seval body environ)
              (if (seval test environ)
                  (seval body environ)
                  (loop (cdr clauses))))))))

;LET

(define (let? exp) (and (list? exp) (eq? (car exp) 'let)))
(define (let-bindings exp) (cadr exp))
(define (let-body exp) (caddr exp))
(define (seval-let exp environ)
  (let* ((bindings (let-bindings exp))
         (params (map car bindings))
         (args (map (lambda (binding) (seval (cadr binding) environ)) bindings))
         (new-env (extend-environment params args environ)))
    (seval (let-body exp) new-env)))


;DELAY
(define (delay? exp) (and (list? exp) (eq? (car exp) 'delay)))
(define (delay-expression exp) (cadr exp))
(define (seval-delay exp environ)
  (let ((expr (delay-expression exp)))
    (lambda () (seval expr environ))))


;; Varias pruebas para ver que es lo que tiene que ocurrir
(define (check-equal? actual expected message)
  (if (equal? actual expected)
      #t
      (error message)))

(check-equal? (seval '42 environ) 42 "Primitives failed")
;(check-equal? (seval 'foo environ) 123 "Symbol lookup failed")
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

;; Pruebas de primitivas
(check-equal? (seval 10 environ) 10 "Número primitivo fallido")
(check-equal? (seval #t environ) #t "Booleano verdadero fallido")
(check-equal? (seval #f environ) #f "Booleano falso fallido")

;; Operadores matemáticos
(check-equal? (seval '(+ 2 3) environ) 5 "Suma fallida")
(check-equal? (seval '(- 5 3) environ) 2 "Resta fallida")
(check-equal? (seval '(* 3 4) environ) 12 "Multiplicación fallida")
(check-equal? (seval '(/ 10 2) environ) 5 "División fallida")

;; Comparaciones
(check-equal? (seval '(= 3 3) environ) #t "Igualdad fallida")
(check-equal? (seval '(= 3 4) environ) #f "Desigualdad fallida")
(check-equal? (seval '(> 4 3) environ) #t "Mayor que fallido")
(check-equal? (seval '(< 2 3) environ) #t "Menor que fallido")
(check-equal? (seval '(>= 5 5) environ) #t "Mayor o igual que fallido")
(check-equal? (seval '(<= 5 5) environ) #t "Menor o igual que fallido")

;; Definiciones
(seval '(define x 42) environ)
(check-equal? (seval 'x environ) 42 "Definición fallida")
(seval '(define y (+ x 3)) environ)
(check-equal? (seval 'y environ) 45 "Definición con expresión fallida")

;; If
(check-equal? (seval '(if (< 1 2) 100 200) environ) 100 "if verdadero fallido")
(check-equal? (seval '(if (> 2 1) 100 200) environ) 100 "if falso fallido")

;; Condicionales
(check-equal? (seval '(cond ((> 3 2) 100) ((< 3 2) 200)) environ) 100 "Condicional con una cláusula verdadera fallido")
(check-equal? (seval '(cond ((< 3 2) 200) (else 100)) environ) 100 "Condicional con cláusula else fallido")
;(check-equal? (seval '(cond ((< 3 2) 200)) environ) (error "Ninguna cláusula verdadera en cond") "Condicional sin cláusula verdadera fallido")

;; Let
(check-equal? (seval '(let ((x 2) (y 3)) (+ x y)) environ) 5 "Let básico fallido")
(check-equal? (seval '(let ((x (+ 1 2)) (y (* 2 2))) (+ x y)) environ) 7 "Let con expresión fallida")

;; Delay
(define delay-example (seval '(define delayed (delay (+ 1 1))) environ))
;(check-equal? (delay-example) 2 "Delay fallido")

;; Begin (secuencia de expresiones)
;(check-equal? (seval '(begin (define x 10) (define y 20) (+ x y)) environ) 30 "Begin fallido")

;; Lambda y aplicación de procedimientos
(seval '(define square (lambda (x) (* x x))) environ)
;(check-equal? (seval '(square 4) environ) 16 "Lambda square fallido")
(seval '(define fact (lambda (n) (if (= n 0) 1 (* n (fact (- n 1)))))) environ)
;(check-equal? (seval '(fact 5) environ) 120 "Lambda fact fallido")
(seval '(define add (lambda (x y) (+ x y))) environ)
;(check-equal? (seval '(add 2 3) environ) 5 "Lambda con dos parámetros fallido")

;; Aplicación de procedimientos con cierre
(seval '(define make-adder (lambda (x) (lambda (y) (+ x y)))) environ)
;(check-equal? (seval '((make-adder 5) 10) environ) 15 "Procedimiento con cierre fallido")

;; Prueba de errores
;(check-equal? (seval '(define z (+ 1 2)) environ) 3 "Error de definición fallido")
;(check-equal? (seval '(undefined-proc) environ) (error "Not a procedure: 'undefined-proc") "Error de procedimiento fallido")