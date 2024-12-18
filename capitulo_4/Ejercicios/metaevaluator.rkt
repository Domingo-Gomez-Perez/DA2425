#lang racket

; meta.rkt
; The metacircular evaluator from section 4.1

(require rackunit)


(define (seval exp environ)
  ; Evaluate a scheme expression
  (cond ((primitiva? exp) exp)                            ; Primitive just "are". Return back
        ((simbolo? exp) (hash-ref environ exp (lambda () (error "Símbolo no encontrado" exp))))  ; Symbols? Look up in the environment.
        ((define? exp) (seval-define exp environ))
        ((if? exp) (seval-if exp environ))
        ((quote? exp) (seval-quote exp environ))
        ; ((cond? exp) ...)
        ; ((let ...))
        ; ((delay...))
        ((begin? exp) (let loop ((exps (begin-expressions exp)) (result #f))
                        (if (null? exps)
                            result
                            (loop (cdr exps) (seval (car exps) environ)))))
        ((lambda? exp) (let ((params (cadr exp))   ; Parámetros
                             (body (caddr exp)))   ; Cuerpo del lambda
                         (lambda args
                           (seval body (extend-environment params args environ)))))
        ((procedure-application? exp)
                            (let* ((proc (seval (car exp) environ))        ; Evalúa el operador
                            (args (map (lambda (e) (seval e environ)) (cdr exp)))) ; Evalúa los argumentos
                                  (apply proc args)))                        ; Aplica la función si es válida
        (else (error "Error desconocido"))
        )
  )

;defining the environment
(define environ (make-hash))
(hash-set! environ '+ +)
(hash-set! environ '- -)
(hash-set! environ '= =)

;seguir metiendo movidas, es tedioso

(define (extend-environment params args environ)
  (let ((new-env (make-hash))) ; Nuevo hash para el entorno extendido
    ;; Asigna parámetros a argumentos
    (for ([param params] [arg args])
      (hash-set! new-env param arg))
    ;; Combina con el entorno existente
    (for ([(key val) (in-hash environ)])
      (hash-set! new-env key val))
    new-env))




(define (primitiva? exp)
  (or (number? exp) (boolean? exp)))

(define (aplicacion-procedimiento? exp)
  (list? exp)
  )
(define (simbolo? exp)
  (symbol? exp))

(define (lambda? exp)
  (and (list? exp) (eq? (car exp) 'lambda)))

(define (procedure-application? exp)
  (and (list? exp) (not (null? exp))))



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
(define (define-in-environment! name value environ)
  (hash-set! environ name value))




(define (seval-define exp environ)
  (let ((name (define-name exp))               ; Extraer el nombre
        (value (seval (define-value exp) environ))) ; Evaluar el valor
    (define-in-environment! name value environ) ; Actualizar el entorno
    )) ; Retornar el valor definido





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
(hash-set! environ '< <)          ; Agregar comparación menor
(hash-set! environ 'foo 123)      ; Agregar 'foo' como símbolo para prueba
(hash-set! environ 'square (lambda (x) (* x x))) ; Definir square
(hash-set! environ 'fact          ; Definir fact como función lambda recursiva
          (lambda (n)
            (if (= n 0) 1 (* n ((hash-ref environ 'fact) (- n 1))))))
(hash-set! environ '* *) ; Agregar el operador de multiplicación



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
(seval '(define square (lambda (n) (* n n))) environ)
(check-equal? (seval '(square 4) environ) 16 "square failed")

(seval '(define fact (lambda (n) (if (= n 0) 1 (* n (fact (- n 1)))))) environ)
(check-equal? (seval '(fact 5) environ) 120 "fact failed")

(displayln "Si solo sale este mensaje la prueba ha sido un éxito")


