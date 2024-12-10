#lang racket
(require sicp)
(require rackunit)

; uso sicp porque la mayoria de procedimientos que se usan son de ahi y asi no hay problemas de nombres

; meta.rkt
; The metacircular evaluator from section 4.1

; hay que guardar una referencia al apply de verdad antes de definir el nuestro
(define apply-in-underlying-scheme apply)

; Lista de Procedimientos Primitivos (lo que no este aqui no se puede usar porque no esta definido)
; Habria que ir definiendolo cada vesz que iniciemos la app

; lo pongo al principio por si se quiere añadir alguno mas para probar
(define primitive-procedures
  ; Procedimientos matemáticos
  (list (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list 'modulo modulo)
        (list 'abs abs)
        (list 'expt expt)
        (list 'sqrt sqrt)
        (list 'max max)
        (list 'min min)

        (list 'apply apply)
        ; Comparaciones
        (list '= =)
        (list '< <)
        (list '> >)
        (list '<= <=)
        (list '>= >=)
        ; Booleanos
        (list 'not not)
        (list 'boolean? boolean?)
        ; Operaciones con listas
        (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'list list)
        (list 'length length)
        (list 'append append)
        (list 'reverse reverse)
        (list 'list-ref list-ref)
        (list 'list-tail list-tail)
        (list 'null? null?)
        (list 'member member)
        (list 'map map)

        ; Operaciones con cadenas
        (list 'string? string?)
        (list 'string-length string-length)
        (list 'string-append string-append)
        (list 'substring substring)
        (list 'string->list string->list)
        (list 'list->string list->string)
        (list 'string=? string=?)
        ; Operaciones con símbolos
        (list 'symbol? symbol?)
        (list 'symbol->string symbol->string)
        (list 'string->symbol string->symbol)
        ; Entrada/Salida
        (list 'display display)
        (list 'newline newline)
        ; Tipos y conversiones
        (list 'number? number?)
        (list 'integer? integer?)
        (list 'real? real?)
        (list 'exact? exact?)
        (list 'inexact? inexact?)
        (list 'pair? pair?)
        (list 'procedure? procedure?)
        (list 'eq? eq?)
        (list 'equal? equal?)
        ; Tipos de datos
        (list 'vector? vector?)
        (list 'make-vector make-vector)
        (list 'vector-ref vector-ref)
        (list 'vector-set! vector-set!)
        (list 'vector-length vector-length)))

; Forma General de eval (hemos pasado a analyze):
; (define (eval exp env)
;   (cond
;     [(self-evaluating? exp) exp]
;     [(variable? exp) (lookup-variable-value exp env)]
;     [(quoted? exp) (text-of-quotation exp)]
;     [(assignment? exp) (eval-assignment exp env)]
;     [(definition? exp) (eval-definition exp env)]
;     [(if? exp) (eval-if exp env)]
;     [(lambda? exp) (make-procedure (lambda-parameters exp) (lambda-body exp) env)]
;     [(begin? exp) (eval-sequence (begin-actions exp) env)]
;     [(cond? exp) (eval (cond->if exp) env)]
;     [(application? exp) (mi-apply (eval (operator exp) env) (list-of-values (operands exp) env))]
;     [else (error "Unknown expression type: EVAL" exp)]))

; Forma General de apply:
(define (mi-apply procedure arguments)
  (cond
    [(primitive-procedure? procedure) (apply-primitive-procedure procedure arguments)]
    [(compound-procedure? procedure)
     (eval-sequence (procedure-body procedure)
                    (extend-environment (procedure-parameters procedure)
                                        arguments
                                        (procedure-environment procedure)))]))

; Procedure arguments
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env) (list-of-values (rest-operands exps) env))))

; Conditionals
(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

; Sequences
(define (eval-sequence exps env)
  (cond
    [(last-exp? exps) (eval (first-exp exps) env)]
    [else
     (eval (first-exp exps) env)
     (eval-sequence (rest-exps exps) env)]))

; Assignments and definitions
(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp) (eval (assignment-value exp) env) env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp) (eval (definition-value exp) env) env)
  'ok)

; Items autoevaluables: Los únicos items autoevaluables son los números y las cadenas de texto.
(define (self-evaluating? exp)
  (cond
    [(number? exp) true]
    [(string? exp) true]
    [else false]))

; Variables: Las variables son representadas por símbolos.
(define (variable? exp)
  (symbol? exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

; Quote: Las quote tienen la forma (quote ⟨cosas-quote⟩).
(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp)
  (cadr exp))

; Asignaciones: Las asignaciones tienen la forma (set! ⟨var⟩ ⟨valor⟩).
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp)
  (cadr exp))

(define (assignment-value exp)
  (caddr exp))

; Las funciones de la sintaxis son:
(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))

; Expresiones Lambda: Las expresiones lambda son listas que comienzan con el símbolo lambda:
(define (lambda? exp)
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp)
  (cadr exp))
(define (lambda-body exp)
  (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

; Condicionales (if): Los condicionales tienen la forma if con un predicado, un consecuente y una alternativa (opcional).
; Si no hay alternativa, se considera false como alternativa.
(define (if? exp)
  (tagged-list? exp 'if))
(define (if-predicate exp)
  (cadr exp))
(define (if-consequent exp)
  (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

; to transform cond expressions into if expressions:
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

; Expresiones begin: begin empaqueta una secuencia de expresiones en una sola expresión.
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

; transforms a sequence into a single expression
(define (sequence->exp seq)
  (cond
    [(null? seq) seq]
    [(last-exp? seq) (first-exp seq)]
    [else (make-begin seq)]))

(define (make-begin seq)
  (cons 'begin seq))

; Aplicación de Procedimientos: La aplicación de procedimientos es cualquier expresión compuesta que
; no sea de los tipos mencionados anteriormente. El car de la expresión es el operador,
; y el cdr es la lista de operandos.
(define (application? exp)
  (pair? exp))
(define (operator exp)
  (car exp))
(define (operands exp)
  (cdr exp))
(define (no-operands? ops)
  (null? ops))
(define (first-operand ops)
  (car ops))
(define (rest-operands ops)
  (cdr ops))

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
      'false ; no else clause
      (let ([first (car clauses)]
            [rest (cdr clauses)])
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't
                        last: COND->IF" clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))

; Predicados de prueba

; true?: Devuelve #t si el valor no es false.
(define (true? x)
  (not (eq? x false)))

; false?: Devuelve #t si el valor es false.
(define (false? x)
  (eq? x false))

; make-procedure: Crea un procedimiento compuesto.
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

; compound-procedure?: Verifica si un procedimiento es compuesto.
(define (compound-procedure? p)
  (tagged-list? p 'procedure))

; procedure-parameters: Extrae los parámetros de un procedimiento.
(define (procedure-parameters p)
  (cadr p))

; procedure-body: Extrae el cuerpo de un procedimiento.
(define (procedure-body p)
  (caddr p))

; procedure-environment: Extrae el entorno donde se define el procedimiento.
(define (procedure-environment p)
  (cadddr p))

; Ahora los enviroments y frames
; enclosing-environment: Devuelve el entorno envolvente.
(define (enclosing-environment env)
  (cdr env))

; first-frame: Devuelve el primer marco de un entorno.
(define (first-frame env)
  (car env))

; the-empty-environment: El entorno vacío.
(define the-empty-environment '())

; Cada marco del entorno se representa como un par de listas: una lista de variables y una lista de valores.
; make-frame: Crea un nuevo marco de entorno.
(define (make-frame variables values)
  (cons variables values))

; frame-variables: Extrae las variables de un marco.
(define (frame-variables frame)
  (car frame))

; frame-values: Extrae los valores de un marco.
(define (frame-values frame)
  (cdr frame))

; add-binding-to-frame!: Añade una nueva asociación de variable y valor a un marco.
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

; extend-environment: Extiende un entorno con un nuevo marco.
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

; Cosas con variables en el entorno
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond
        [(null? vars) (env-loop (enclosing-environment env))]
        [(eq? var (car vars)) (car vals)]
        [else (scan (cdr vars) (cdr vals))]))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ([frame (first-frame env)]) (scan (frame-variables frame) (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond
        [(null? vars) (env-loop (enclosing-environment env))]
        [(eq? var (car vars)) (set-car! vals val)]
        [else (scan (cdr vars) (cdr vals))]))
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let ([frame (first-frame env)]) (scan (frame-variables frame) (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ([frame (first-frame env)])
    (define (scan vars vals)
      (cond
        [(null? vars) (add-binding-to-frame! var val frame)]
        [(eq? var (car vars)) (set-car! vals val)]
        [else (scan (cdr vars) (cdr vals))]))
    (scan (frame-variables frame) (frame-values frame))))

; Ejecutando el Evaluador como un Programa

; primitive-procedure?: Verifica si el procedimiento es primitivo.
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

; primitive-implementation: Recupera el procedimiento de implementación desde la lista.
(define (primitive-implementation proc)
  (cadr proc))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc))) primitive-procedures))

; Aplicando Procedimientos Primitivos
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme (primitive-implementation proc) args))

(define (setup-environment)
  (let ([initial-env (extend-environment (primitive-procedure-names)
                                         (primitive-procedure-objects)
                                         the-empty-environment)])
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

; el bucle principal
(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ([input (read)])
    (let ([output (eval input the-global-environment)])
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

; prompt-for-input: Muestra el mensaje para ingresar una expresión.
(define (prompt-for-input string)
  (newline)
  (newline)
  (display string)
  (newline))

; announce-output: Muestra el mensaje para el resultado de la evaluación.
(define (announce-output string)
  (newline)
  (display string)
  (newline))

; user-print: Imprime el resultado, evitando imprimir detalles innecesarios de los procedimientos complejos.
(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

; ahora iria aqui las cosas de separar analisis sintactico y ejecucion
(define (eval exp env)
  ((analyze exp) env))

(define (analyze exp)
  (cond
    [(self-evaluating? exp) (analyze-self-evaluating exp)]
    [(quoted? exp) (analyze-quoted exp)]
    [(variable? exp) (analyze-variable exp)]
    [(assignment? exp) (analyze-assignment exp)]
    [(definition? exp) (analyze-definition exp)]
    [(if? exp) (analyze-if exp)]
    [(lambda? exp) (analyze-lambda exp)]
    [(begin? exp) (analyze-sequence (begin-actions exp))]
    [(cond? exp) (analyze (cond->if exp))]
    [(application? exp) (analyze-application exp)]
    [else (error "Unknown expression
                 type: ANALYZE" exp)]))

; Expresiones autoevaluables:
(define (analyze-self-evaluating exp)
  (lambda (env) exp))

; Expresiones con quote:
(define (analyze-quoted exp)
  (let ([qval (text-of-quotation exp)]) (lambda (env) qval)))

; Variables:
(define (analyze-variable exp)
  (lambda (env) (lookup-variable-value exp env)))

(define (analyze-assignment exp)
  (let ([var (assignment-variable exp)]
        [vproc (analyze (assignment-value exp))])
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

; Condicionales (if): Se analizan el predicado, la consecuencia y la alternativa una sola vez:
(define (analyze-if exp)
  (let ([pproc (analyze (if-predicate exp))]
        [cproc (analyze (if-consequent exp))]
        [aproc (analyze (if-alternative exp))])
    (lambda (env)
      (if (true? (pproc env))
          (cproc env)
          (aproc env)))))

; Expresiones lambda: La eficiencia mejora considerablemente porque el cuerpo de un lambda se analiza solo una vez,
; aunque la función se aplique muchas veces:
(define (analyze-lambda exp)
  (let ([vars (lambda-parameters exp)]
        [bproc (analyze-sequence (lambda-body exp))])
    (lambda (env) (make-procedure vars bproc env))))

(define (analyze-definition exp)
  (let ([var (definition-variable exp)]
        [vproc (analyze (definition-value exp))])
    (lambda (env)
      (define-variable! var (vproc env) env)
      'ok)))

(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env)
      (proc1 env)
      (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs)) (cdr rest-procs))))
  (let ([procs (map analyze exps)])
    (if (null? procs)
        (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))

(define (analyze-application exp)
  (let ([fproc (analyze (operator exp))]
        [aprocs (map analyze (operands exp))])
    (lambda (env) (execute-application (fproc env) (map (lambda (aproc) (aproc env)) aprocs)))))

(define (execute-application proc args)
  (cond
    [(primitive-procedure? proc) (apply-primitive-procedure proc args)]
    [(compound-procedure? proc)
     ((procedure-body proc)
      (extend-environment (procedure-parameters proc) args (procedure-environment proc)))]
    [else (error "Unknown procedure type:
                      EXECUTE-APPLICATION" proc)]))

; Para pruebas todo esto
(define (check-equal? actual expected message)
  (if (equal? actual expected)
      (displayln (string-append "Test passed: " message))
      (error (string-append "Test failed: " message
                            "\n  Expected: " (format "~a" expected)
                            "\n  Got: " (format "~a" actual)))))

; definimos el enviroment ya al final del todo
(define the-global-environment (setup-environment))


(define (ejecucion-programa variable)
  (if variable
      (begin
        (driver-loop))
      (begin
        (check-equal? (eval '42 the-global-environment) 42 "Primitives failed")
        (eval '(define foo 123) the-global-environment)
        (check-equal? (eval 'foo the-global-environment) 123 "Symbol lookup failed")
        (eval '(define x 42) the-global-environment)
        (check-equal? (eval 'x the-global-environment) 42 "Simple define failed")
        (eval '(define y (+ 2 3)) the-global-environment)
        (check-equal? (eval 'y the-global-environment) 5 "Expression define failed")
        (check-equal? (eval '(quote x) the-global-environment) 'x "Quoting failed")

        (check-equal? (eval '(if (< 2 3) 1 (/ 1 0)) the-global-environment) 1 "if-true failed")
        (check-equal? (eval '(if (< 3 2) (/ 1 0) 1) the-global-environment) 1 "if-false failed")

        ; ; Procedures
        (eval '(define square (lambda (x) (* x x))) the-global-environment)
        (check-equal? (eval '(square 4) the-global-environment) 16 "square failed")

        (eval '(define fact
                 (lambda (n)
                   (if (= n 0)
                       1
                       (* n (fact (- n 1))))))
              the-global-environment)
        (check-equal? (eval '(fact 5) the-global-environment) 120 "fact failed"))))


; PRUEBA FINAL

;cambiar a true o false para abrir interprete o pruebas de Domingo
(define interprete-de-linea? true)
(ejecucion-programa interprete-de-linea?)




; Ejemplo linea de comandos
;;; M-Eval input:
;;(define (append x y)
;(if (null? x)
; y
;(cons (car x) (append (cdr x) y))))

;;; M-Eval value:
; ok

; ;;; M-Eval input:
; (append '(a b c) '(d e f))

; ;;; M-Eval value:
; (a b c d e f)

;; Varias pruebas para ver que es lo que tiene que ocurrir