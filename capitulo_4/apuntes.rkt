#lang racket

#|
Capítulo 4: Abstracción Metalingüística

Hecho por: Gabriel Gomez Garcia

Este capítulo es el fin de los conceptos aprendidos en los tres capítulos anteriores:
la naturaleza de la computación y las abstracciones en torno a los datos y la evaluación.
Aquí se explora la creación de un intérprete de lenguaje de programación capaz de ejecutar
todos los programas vistos hasta ahora. Este intérprete puede modificarse para cambiar el
comportamiento del lenguaje.
|#

#|
Eval
----

En lenguajes como Scheme o Python, existe una función `eval` que evalúa código dinámicamente.
Ejemplo en Python:
eval('3 + 4 * 5 + 10') 33 exec('for i in range(5): print(i)') 0 1 2 3 4

En Scheme, podemos manipular directamente programas porque son representados como estructuras
de datos. Ejemplo:

(define prog '(define (fact n) (if (= n 1) 1 (* n (fact (- n 1))))))
(car prog)    ; 'define
(cadr prog)   ; '(fact n)
(caddr prog)  ; '(if ...)
|#

#|
Evaluación como proceso
------------------------

Todo cómputo sigue un flujo de evaluación y aplicación:

Ejemplo:
(+ (* 3 4) (* 6 7))
  - Primero se evalúan las subexpresiones: (+ 12 42)
  - Luego se aplica el operador: 54

Diseño de lenguajes:
- Cuándo y cómo se evalúan las expresiones.
- Cuándo y cómo se aplican los procedimientos.

Las decisiones de diseño cambian la naturaleza del lenguaje.
|#

#|
El Evaluador Metacircular
--------------------------

Definición:
- Es un evaluador escrito en el mismo lenguaje que evalúa (un programa en Scheme que evalúa Scheme).

Objetivo:
- Crear un evaluador funcional basado en la Sección 4.1 del libro.

Metas adicionales (no hace falta):
- Implementar extensiones como Lazy Scheme (4.2) o Amb (4.3).
|#

#| Seccion del libro 4.1 |#
; ####################################################################


¿Cómo funciona el Metacircular Evaluator?
El evaluador sigue el modelo de entorno (environment model) descrito anteriormente en el libro. 
Este modelo define cómo se evalúan las expresiones en Lisp:

Evaluar combinaciones:
Si tenemos una expresión como (+ 2 3), evaluamos las subexpresiones primero (2 y 3) y luego aplicamos 
el operador + a esos valores.
En Lisp, una combinación es cualquier expresión que no sea un "formulario especial" (special form).

Aplicar funciones:
Si la expresión es una función (como +), el evaluador se asegura de vincular correctamente los argumentos
de la función a los parámetros definidos.
Por ejemplo, para evaluar una función definida por el usuario, el evaluador utiliza entornos que asocian
variables con valores.

4.1.1  Los Procedimientos eval y apply

1. El Procedimiento eval
El procedimiento eval es responsable de evaluar las expresiones en el lenguaje. Toma dos argumentos: 
una expresión y un entorno, y se encarga de clasificar la expresión y dirigir su evaluación. 
El proceso de evaluación se organiza mediante un análisis de casos según el tipo sintáctico de la expresión.

Clasificación de Expresiones:
Expresiones autoevaluables: como números, devuelven la expresión tal cual.
Variables: se busca su valor en el entorno.
Formas especiales: incluyen quote, if, lambda, etc., y requieren un tratamiento especial durante la evaluación.

Forma General de eval:
(define (eval exp env)
  (cond ((self-evaluating? exp) 
         exp)
        ((variable? exp) 
         (lookup-variable-value exp env))
        ((quoted? exp) 
         (text-of-quotation exp))
        ((assignment? exp) 
         (eval-assignment exp env))
        ((definition? exp) 
         (eval-definition exp env))
        ((if? exp) 
         (eval-if exp env))
        ((lambda? exp)
         (make-procedure 
          (lambda-parameters exp)
          (lambda-body exp)
          env))
        ((begin? exp)
         (eval-sequence 
          (begin-actions exp) 
          env))
        ((cond? exp) 
         (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values 
                 (operands exp) 
                 env)))
        (else
         (error "Unknown expression type: EVAL" exp))))

Componentes clave:
Evaluación de Formas Especiales:
Quote: Retorna la expresión tal cual (sin evaluación).
Assign y Define: Modifican el entorno con la nueva variable y su valor.
If: Evaluación condicional, donde se evalúan sus ramas dependiendo del valor de la condición.
Lambda: Convierte una expresión lambda en un procedimiento aplicable.
Begin: Evalúa las expresiones en orden secuencial.
Cond: Se convierte en una serie de if para su evaluación.


2. El Procedimiento apply
El procedimiento apply se encarga de aplicar un procedimiento a una lista de argumentos. 
Clasifica los procedimientos en:
Primitivos: Utiliza apply-primitive-procedure.
Compuestos: Se evalúan secuencialmente los cuerpos del procedimiento, creando un nuevo entorno que 
asocia los parámetros con los argumentos correspondientes.

Forma General de apply:
(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure 
          procedure 
          arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters 
              procedure)
             arguments
             (procedure-environment 
              procedure))))))

Evaluación de los Argumentos:
apply utiliza list-of-values para evaluar cada operando y devolver su valor correspondiente.

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values 
             (rest-operands exps) 
             env))))


3. Evaluación de Condicionales: eval-if
Para una expresión if, se evalúa la parte del predicado, y dependiendo de si el predicado es 
verdadero o falso, se evalúan las ramas correspondientes.

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))
Nota: El uso de true? muestra cómo la representación de la verdad puede variar entre el lenguaje implementado
y el lenguaje de implementación.

4. Evaluación de Secuencias: eval-sequence
Este procedimiento evalúa una secuencia de expresiones, una por una, y devuelve el valor de la 
última expresión evaluada. Se utiliza tanto en el cuerpo de los procedimientos como en las expresiones begin.

(define (eval-sequence exps env)
  (cond ((last-exp? exps) 
         (eval (first-exp exps) env))
        (else 
         (eval (first-exp exps) env)
         (eval-sequence (rest-exps exps) 
                        env))))

5. Asignaciones y Definiciones:
Asignaciones: Se busca el valor a asignar y luego se actualiza el entorno con set-variable-value!.
(define (eval-assignment exp env)
  (set-variable-value! 
   (assignment-variable exp)
   (eval (assignment-value exp) env)
   env)
  'ok)

Definiciones: Similar a las asignaciones, pero se crea una nueva variable en el entorno con define-variable!.
(define (eval-definition exp env)
  (define-variable! 
    (definition-variable exp)
    (eval (definition-value exp) env)
    env)
  'ok)

#| 4.1.2Representing Expressions |#

La evaluación de expresiones en este entorno sigue una aproximación similar a la diferenciación 
simbólica mencionada en el capítulo anterior. Al igual que en el programa de diferenciación, las
expresiones compuestas se evalúan recursivamente, operando en los componentes de la expresión y 
combinando los resultados dependiendo del tipo de expresión. Esto se logra a través de la abstracción 
de datos, lo que permite separar las reglas generales de operación de los detalles de cómo se representan 
las expresiones.

Vamos a ver como es cada cosa:

Items autoevaluables: Los únicos items autoevaluables son los números y las cadenas de texto.
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

Variables: Las variables son representadas por símbolos.
(define (variable? exp) (symbol? exp))

Quote: Las quote tienen la forma (quote ⟨cosas-quote⟩).
(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp)
  (cadr exp))

Asignaciones: Las asignaciones tienen la forma (set! ⟨var⟩ ⟨valor⟩).
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) 
  (cadr exp))

(define (assignment-value exp) (caddr exp))

Definiciones: Las definiciones tienen la forma (define ⟨var⟩ ⟨valor⟩) o la forma 
(define (⟨var⟩ ⟨param₁⟩ … ⟨paramₙ⟩) ⟨cuerpo⟩). Esta última forma es azúcar sintáctico para:
(define ⟨var⟩
  (lambda (⟨param₁⟩ … ⟨paramₙ⟩)
    ⟨cuerpo⟩))

Las funciones de la sintaxis son:
(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda 
       (cdadr exp)   ; parámetros formales
       (cddr exp)))) ; cuerpo

Expresiones Lambda: Las expresiones lambda son listas que comienzan con el símbolo lambda:
(define (lambda? exp) 
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))

Condicionales (if): Los condicionales tienen la forma if con un predicado, un consecuente y una alternativa (opcional). 
Si no hay alternativa, se considera false como alternativa.
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

Expresiones begin: begin empaqueta una secuencia de expresiones en una sola expresión.
(define (begin? exp) 
  (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

Aplicación de Procedimientos: La aplicación de procedimientos es cualquier expresión compuesta que 
no sea de los tipos mencionados anteriormente. El car de la expresión es el operador, 
y el cdr es la lista de operandos.
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

Expresiones Derivadas
Algunas formas especiales en el lenguaje pueden definirse en términos de otras expresiones, 
en lugar de implementarse directamente. Un ejemplo es cond, que puede implementarse como un anidamiento
de expresiones if. Por ejemplo, una expresión cond:
(cond ((> x 0) x)
      ((= x 0) (display 'zero) 0)
      (else (- x)))

Se reduce a:
(if (> x 0)
    x
    (if (= x 0)
        (begin (display 'zero) 0)
        (- x)))
Esto simplifica el evaluador, ya que reduce la cantidad de formas especiales para las que debe 
especificarse explícitamente el proceso de evaluación.

Funciones auxiliares para manejar cond:
(define (cond? exp) 
  (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))
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
      'false     ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp 
                 (cond-actions first))
                (error "ELSE clause isn't 
                        last: COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp 
                      (cond-actions first))
                     (expand-clauses 
                      rest))))))
Las expresiones que decidimos implementar como transformaciones sintácticas, como cond, 
se llaman expresiones derivadas.


#| 4.1.3 Estructuras de Datos del Evaluador |#

En este apartado, se ven las estructuras de datos utilizadas en un evaluador para representar 
procedimientos, entornos, y valores booleanos dentro de la ejecución de un programa. 
Estas estructuras son esenciales para la manipulación de los datos mientras se evalúan las expresiones.

Predicados de prueba
Para la evaluación de condicionales, se considera que cualquier valor que no sea el objeto false se 
considera verdadero. Los procedimientos para esto son:

true?: Devuelve #t si el valor no es false.
(define (true? x)
  (not (eq? x false)))

false?: Devuelve #t si el valor es false.
(define (false? x)
  (eq? x false))

Representación de procedimientos
El evaluador debe manejar tanto procedimientos primitivos como procedimientos compuestos. 
Para los procedimientos primitivos, el sistema utiliza dos mecanismos básicos:

apply-primitive-procedure: Aplica un procedimiento primitivo a una lista de argumentos.

(apply-primitive-procedure ⟨proc⟩ ⟨args⟩)
primitive-procedure?: Verifica si un procedimiento es primitivo.

(primitive-procedure? ⟨proc⟩)
Para los procedimientos compuestos, estos se construyen con parámetros, cuerpo del procedimiento 
y el entorno donde se define. La función make-procedure se usa para crearlos:

make-procedure: Crea un procedimiento compuesto.
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

compound-procedure?: Verifica si un procedimiento es compuesto.
(define (compound-procedure? p)
  (tagged-list? p 'procedure))

procedure-parameters: Extrae los parámetros de un procedimiento.
(define (procedure-parameters p) (cadr p))

procedure-body: Extrae el cuerpo de un procedimiento.
(define (procedure-body p) (caddr p))

procedure-environment: Extrae el entorno donde se define el procedimiento.
(define (procedure-environment p) (cadddr p))

Operaciones sobre Entornos
Un entorno es una secuencia de marcos (frames), cada uno de los cuales es una tabla de asociaciones 
entre variables y sus valores. Las siguientes operaciones permiten manipular estos entornos:

lookup-variable-value: Busca el valor de una variable en un entorno.
(lookup-variable-value ⟨var⟩ ⟨env⟩)

extend-environment: Crea un nuevo entorno que añade un marco con asociaciones entre variables y sus valores.
(extend-environment ⟨variables⟩ ⟨values⟩ ⟨base-env⟩)

define-variable!: Añade una nueva variable a la primera capa de un entorno.
(define-variable! ⟨var⟩ ⟨value⟩ ⟨env⟩)

set-variable-value!: Cambia el valor de una variable en un entorno.
(set-variable-value! ⟨var⟩ ⟨value⟩ ⟨env⟩)

Para implementar estas operaciones, un entorno se representa como una lista de marcos. 
El entorno de un entorno es el cdr de esta lista, y el entorno vacío se representa como la lista vacía.

enclosing-environment: Devuelve el entorno envolvente.
(define (enclosing-environment env) (cdr env))

first-frame: Devuelve el primer marco de un entorno.
(define (first-frame env) (car env))

the-empty-environment: El entorno vacío.
(define the-empty-environment '())

Cada marco del entorno se representa como un par de listas: una lista de variables y una lista de valores. 
Las funciones asociadas a esta estructura son:

make-frame: Crea un nuevo marco de entorno.
(define (make-frame variables values)
  (cons variables values))

frame-variables: Extrae las variables de un marco.
(define (frame-variables frame) (car frame))

frame-values: Extrae los valores de un marco.
(define (frame-values frame) (cdr frame))

add-binding-to-frame!: Añade una nueva asociación de variable y valor a un marco.
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

Extensión de entornos
Para extender un entorno, se crea un nuevo marco con una lista de variables y valores, y luego se agrega
este marco al entorno actual:

extend-environment: Extiende un entorno con un nuevo marco.
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" 
                 vars 
                 vals)
          (error "Too few arguments supplied" 
                 vars 
                 vals))))

Búsqueda de variables en entornos
Para buscar el valor de una variable en un entorno, se escanean los marcos desde el más cercano 
al más lejano. Si no se encuentra la variable, se lanza un error.

lookup-variable-value: Busca el valor de una variable en el entorno.
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
              (frame-values frame))))))

Modificación de valores de variables
Para modificar el valor de una variable en un entorno, se busca el valor asociado y se actualiza. 
Si no se encuentra, se lanza un error.

set-variable-value!: Cambia el valor de una variable.
(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop 
              (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) 
                        (cdr vals)))))
  (if (eq? env the-empty-environment)
      (error "Unbound variable: SET!" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame))))))

Definición de variables
Cuando se define una nueva variable, se busca primero en el marco actual. Si ya existe una asociación para la variable, se actualiza. Si no, se crea una nueva asociación en el marco.

define-variable!: Define una nueva variable.
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! 
              var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) 
                        (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

Conclusión
Estas estructuras de datos y operaciones sobre entornos permiten que el evaluador maneje procedimientos 
y variables de manera eficiente, aunque la representación de entornos descrita aquí es conceptual y 
no necesariamente eficiente en un sistema de producción. Este enfoque facilita la abstracción de los 
detalles de implementación, permitiendo modificar la representación de los entornos si es necesario, 
sin afectar al resto del evaluador.


#| 4.1.4 Ejecutando el Evaluador como un Programa |#

En esta sección, se describe cómo el programa evaluador está diseñado para evaluar expresiones Lisp. 
La ventaja de implementar el evaluador como un programa es que puede ejecutarse dentro de Lisp, 
proporcionándonos un modelo operativo de cómo Lisp evalúa expresiones. Este marco permite experimentar 
con las reglas de evaluación.

Objetivo del Evaluador
El evaluador reduce finalmente las expresiones a la aplicación de procedimientos primitivos. 
Por lo tanto, el evaluador debe invocar el sistema Lisp subyacente para modelar la aplicación de estos 
procedimientos primitivos.

Configuración del Entorno Global
Se configura un entorno global donde los procedimientos primitivos están vinculados a nombres, 
lo que permite que la función eval encuentre el objeto asociado con el operador de una aplicación. 
El entorno también incluye vinculaciones para los símbolos true y false, de manera que se puedan usar 
en expresiones.
(define (setup-environment)
  (let ((initial-env
         (extend-environment 
          (primitive-procedure-names)
          (primitive-procedure-objects)
          the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment 
  (setup-environment))

Representación de los Procedimientos Primitivos
Los procedimientos primitivos se representan como listas. Cada lista comienza con el símbolo primitive 
y contiene el procedimiento del sistema Lisp subyacente que implementa la operación. 
El sistema usa las siguientes funciones para trabajar con los procedimientos primitivos:

primitive-procedure?: Verifica si el procedimiento es primitivo.
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

primitive-implementation: Recupera el procedimiento de implementación desde la lista.
(define (primitive-implementation proc) 
  (cadr proc))

Lista de Procedimientos Primitivos
Se proporciona una lista de procedimientos primitivos, cada uno representado como una lista con el 
nombre del procedimiento y su implementación correspondiente.
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        ⟨más primitivos⟩))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) 
         (list 'primitive (cadr proc)))
       primitive-procedures))

Aplicando Procedimientos Primitivos
Los procedimientos primitivos se aplican usando el procedimiento de implementación y invocándolo con 
los argumentos proporcionados.
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

Bucle del Driver
El evaluador metacircular utiliza un bucle del driver para simular el típico ciclo de 
lectura-evaluación-impresión (REPL) de los sistemas Lisp. Este bucle:

Solicita una entrada.
Lee la expresión de entrada.
Evalúa la expresión en el entorno global.
Imprime el resultado.
(define input-prompt  ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output 
           (eval input 
                 the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

Funciones Auxiliares para el Bucle
Se usan funciones auxiliares para facilitar la entrada y salida:

prompt-for-input: Muestra el mensaje para ingresar una expresión.
(define (prompt-for-input string)
  (newline) (newline) 
  (display string) (newline))

announce-output: Muestra el mensaje para el resultado de la evaluación.
(define (announce-output string)
  (newline) (display string) (newline))

user-print: Imprime el resultado, evitando imprimir detalles innecesarios de los procedimientos complejos.
(define (user-print object)
  (if (compound-procedure? object)
      (display 
       (list 'compound-procedure
             (procedure-parameters object)
             (procedure-body object)
             '<procedure-env>))
      (display object)))

Ejemplo de Interacción
Al ejecutar el bucle del driver, se puede definir y evaluar funciones dentro de un entorno global. Ejemplo:
(define the-global-environment 
  (setup-environment))

(driver-loop)

;;; M-Eval input:
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

;;; M-Eval value:
ok

;;; M-Eval input:
(append '(a b c) '(d e f))

;;; M-Eval value:
(a b c d e f)
Este ejemplo muestra cómo se definen procedimientos, como append, y 
cómo se evalúan expresiones en el entorno configurado.

#| 4.1.5 Datos como Programas |#

Al pensar en un programa Lisp que evalúa expresiones Lisp, puede ser útil hacer una analogía. 
Una visión operativa del significado de un programa es que un programa es una descripción de una 
máquina abstracta (posiblemente infinitamente grande). Por ejemplo, consideremos el programa familiar 
para calcular factoriales:
(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))
Podemos considerar este programa como la descripción de una máquina que contiene partes que decrecen, 
multiplican y prueban la igualdad, junto con un interruptor de dos posiciones y otra máquina factorial. 
(La máquina factorial es infinita porque contiene otra máquina factorial dentro de ella). La Figura 4.2 
muestra un diagrama de flujo para la máquina factorial, mostrando cómo las partes están conectadas.

De manera similar, podemos ver el evaluador como una máquina muy especial que toma como entrada una 
descripción de una máquina. Dada esta entrada, el evaluador se configura para emular la máquina descrita. 
Por ejemplo, si alimentamos al evaluador la definición de factorial, como se muestra en la Figura 4.3, 
el evaluador podrá calcular factoriales.

Desde esta perspectiva, nuestro evaluador se ve como una máquina universal. Imita otras máquinas cuando 
estas se describen como programas Lisp. Esto es sorprendente. Intente imaginar un evaluador análogo para 
circuitos eléctricos. Sería un circuito que toma como entrada una señal que codifica los planes para otro 
circuito, como un filtro. Dada esta entrada, el evaluador de circuitos se comportaría como un filtro con 
la misma descripción. Tal circuito eléctrico universal es casi inimaginablemente complejo. Es notable que 
el evaluador de programas sea un programa relativamente simple.

Otro aspecto sorprendente del evaluador es que actúa como un puente entre los objetos de datos que manipula 
nuestro lenguaje de programación y el propio lenguaje de programación. Imagina que el programa evaluador 
(implementado en Lisp) está en ejecución y que un usuario está escribiendo expresiones al evaluador y 
observando los resultados. Desde la perspectiva del usuario, una expresión de entrada como (* x x) 
es una expresión en el lenguaje de programación, que el evaluador debe ejecutar. Sin embargo, desde 
la perspectiva del evaluador, la expresión es simplemente una lista (en este caso, una lista de tres 
símbolos: *, x y x) que debe ser manipulada de acuerdo con un conjunto bien definido de reglas.

El hecho de que los programas del usuario sean los datos del evaluador no debe ser una fuente de confusión. 
De hecho, a veces es conveniente ignorar esta distinción, y darle al usuario la capacidad de evaluar 
explícitamente un objeto de datos como una expresión Lisp, al hacer que eval esté disponible para su 
uso en programas. Muchos dialectos de Lisp proporcionan un procedimiento eval primitivo que toma como 
argumentos una expresión y un entorno, y evalúa la expresión en relación con el entorno.

Por ejemplo:
(eval '(* 5 5) user-initial-environment)
y
(eval (cons '* (list 5 5)) 
      user-initial-environment)

En verdad esto es como la maquina universal de turing. o.o


#| 4.1.6 Definiciones Internas |#

En el modelo de evaluación basado en entornos y en el evaluador metacircular, las definiciones se ejecutan
secuencialmente, extendiendo el marco del entorno una definición a la vez. Esto es conveniente para el 
desarrollo interactivo de programas, ya que permite mezclar libremente la aplicación de procedimientos 
con la definición de nuevos procedimientos.

El problema de las definiciones internas
Consideremos el siguiente procedimiento con definiciones internas:
(define (f x)
  (define (even? n)
    (if (= n 0)
        true
        (odd? (- n 1))))
  (define (odd? n)
    (if (= n 0)
        false
        (even? (- n 1))))
  ⟨rest of body of f⟩)

Aquí, nuestra intención es que el nombre odd? en el cuerpo del procedimiento even? se refiera al 
procedimiento odd?, que se define después de even?. La área de validez (scope) del nombre odd? debe 
abarcar todo el cuerpo de f, no solo la parte del cuerpo que empieza en el punto donde se define odd?.

Esto es especialmente importante porque odd? se define en términos de even?, y ambos procedimientos 
son mutuamente recursivos. Para que esto funcione correctamente, las definiciones deben interpretarse 
como si los nombres even? y odd? se añadieran al entorno simultáneamente.

Por qué funciona el evaluador actual
Nuestro intérprete evalúa correctamente las llamadas a f, pero esto ocurre por una razón "accidental". 
Como las definiciones internas (even? y odd?) aparecen primero en el cuerpo de f, no se evalúan llamadas 
a estos procedimientos hasta que ambas definiciones han sido procesadas. Esto asegura que odd? estará 
definido cuando se evalúe even?.

Sin embargo, este comportamiento no es general. Si las definiciones internas no aparecen al principio 
del cuerpo del procedimiento o si las expresiones de valor de las definiciones dependen de otras 
definiciones internas, este enfoque secuencial podría fallar.

Una solución: Definiciones simultáneas
Una forma sencilla de manejar correctamente las definiciones internas es asegurarse de que las variables
locales definidas tengan un alcance verdaderamente simultáneo. Esto puede lograrse creando todas las 
variables locales en el entorno actual antes de evaluar cualquier expresión de valor. 
Esto se implementa mediante una transformación de sintaxis en expresiones lambda.

Por ejemplo, consideremos un procedimiento con definiciones internas como este:
(lambda ⟨vars⟩
  (define u ⟨e1⟩)
  (define v ⟨e2⟩)
  ⟨e3⟩)
Podemos transformarlo en:

(lambda ⟨vars⟩
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (set! u ⟨e1⟩)
    (set! v ⟨e2⟩)
    ⟨e3⟩))
Aquí, *unassigned* es un símbolo especial que provoca un error si se intenta usar una variable 
que aún no ha sido asignada. Este enfoque asegura que todas las variables internas (u y v en este caso) 
se creen simultáneamente antes de evaluar las expresiones de valor asociadas.

Alternativa: Restricción de dependencias
Esta alternativa impone la restricción de que los valores de las variables definidas deben poder 
evaluarse sin depender de los valores de otras variables definidas. Este enfoque, aunque más restrictivo, 
elimina posibles dependencias circulares entre las definiciones.

#| 4.1.7Separación del análisis sintáctico y la ejecución |#

Problema: Análisis y ejecución entrelazados
En el evaluador simple presentado anteriormente, cada vez que se evalúa una expresión:

Se analiza su sintaxis (por ejemplo, para determinar si es un if, un lambda o una aplicación).
Luego, se ejecuta la expresión.
Por ejemplo:
(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))
Si evaluamos (factorial 4), el evaluador:

Determina repetidamente que el cuerpo de factorial es una expresión if.
Extrae el predicado (= n 1) y lo evalúa.
Hace lo mismo para la expresión (* (factorial (- n 1)) n) y sus subexpresiones.
Este proceso repite el análisis de la misma expresión muchas veces, lo que resulta ineficiente.

Solución: Separar análisis y ejecución
El análisis sintáctico se realiza una sola vez.
Se genera un procedimiento de ejecución que encapsula el trabajo de evaluar la expresión en un entorno dado.
Esto se logra separando la función eval en dos partes:

analyze: Realiza el análisis sintáctico y devuelve un procedimiento de ejecución.
Procedimiento de ejecución: Se aplica al entorno para realizar la evaluación.
Ahora, eval queda definido como:
(define (eval exp env)
  ((analyze exp) env))
Aquí, analyze genera un procedimiento que se ejecutará con el entorno adecuado.


Estructura de analyze
analyze realiza un análisis basado en el tipo de expresión, similar a cómo lo hacía eval. 
Sin embargo, en lugar de ejecutar directamente la expresión, devuelve un procedimiento que encapsula 
la ejecución. Por ejemplo:

Expresiones autoevaluables:
(define (analyze-self-evaluating exp)
  (lambda (env) exp))
El procedimiento resultante ignora el entorno y simplemente devuelve el valor.

Expresiones con quote:
(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env) qval)))
Aquí, el texto de la cita se extrae una vez durante el análisis, ahorrando trabajo en la ejecución.

Variables:
(define (analyze-variable exp)
  (lambda (env) 
    (lookup-variable-value exp env)))
El valor de la variable depende del entorno, por lo que su búsqueda se retrasa hasta la ejecución.


Ventajas en estructuras más complejas
Asignaciones y definiciones: Durante el análisis, se analiza el valor asignado, 
lo que evita analizarlo múltiples veces durante la ejecución:
(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

Condicionales (if): Se analizan el predicado, la consecuencia y la alternativa una sola vez:
(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env)
      (if (true? (pproc env))
          (cproc env)
          (aproc env)))))

Expresiones lambda: La eficiencia mejora considerablemente porque el cuerpo de un lambda se analiza solo una vez, 
aunque la función se aplique muchas veces:
(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) 
      (make-procedure vars bproc env))))

(hay mas en el libro que no he puesto)

Secuencias de expresiones
Para analizar secuencias (como en un begin o el cuerpo de un lambda):
Cada expresión se analiza por separado.
Los procedimientos resultantes se combinan en un procedimiento que ejecuta las expresiones en orden:
(define (analyze-sequence exps)
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))

Aplicaciones
En una aplicación, el operador y los operandos se analizan una sola vez. El procedimiento resultante:
Evalúa el operador para obtener la función.
Evalúa los operandos para obtener los argumentos.
Llama a la función con esos argumentos:
(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env)
      (execute-application 
       (fproc env)
       (map (lambda (aproc) (aproc env))
            aprocs)))))
La función auxiliar execute-application maneja la aplicación de procedimientos primitivos y compuestos.

Separar el análisis sintáctico de la ejecución hace que el evaluador sea más eficiente, 
ya que el análisis se realiza solo una vez, incluso si una expresión se evalúa repetidamente. 
Esto es especialmente útil para programas complejos o funciones que se llaman muchas veces.