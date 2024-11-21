#lang racket

#|
Chapter 3 : Modularity, Objects, and State

Hecho por: Gabriel Gomez Garcia
|#


#| 
3.1 Assignment and Local State 
|#

; Ahora vamos a empezar a ver las cosas como objetos.
; Un objeto es una colección de datos y funciones que operan sobre esos datos.
; Para utilizar un objeto necesitamos crearlo y luego acceder a sus atributos y métodos.

#| 3.1.1Local State Variables |#

; Nos explica con el ejemplo de la cuenta de un banco como puede ser que vaya cambiando poco
; a poco . Por ejemplo, si tenemos una cuenta con 1000 euros y hacemos un deposito de 500 euros
; la cuenta ahora tiene 1500 euros.

(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))

; Esto se puede hacer gracias al set! que permite cambiar el valor a una variable ya definida.
; Si nos fijamos tambien usa begin para hacer varias cosas a la vez pero eso ya lo habiamos visto

; Para terminar de definir un objeto bien y que tenga sus metodos podemos usar dispatch

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
  dispatch)

; Example

(define acc (make-account 100))
((acc 'withdraw) 30)
((acc 'deposit) 75)

; Así se producen objetos por separado y cada uno tiene su balance creado

; los corchetes se pueden usar como los parentesis igualitos pero sirven para mejorar
; la legibilidad de nuestro código. Se suelen usar en condiciones y let.


#| 3.1.2The Benefits of Introducing Assignment |#

; cuenta cosas suyas que no sirven mucho (que pesao con el montecarlo).

#| 3.1.3The Costs of Introducing Assignment |#

; El problema con esto, ahora no siepre sabemos que es lo que va a retornar un metodo con una entrada.
; Antes todo se hacia con el modelo de sustitucion y pues siempre salia lo mismo pero ahroa como modificamos
; variables, ya no siempre sale lo mismo. Ya no sirve el modelo de sustitucion :c

; Luego explica mas de por que no son lo mismo ya y no se puede saber. Desde fuera del objeto no podemos
; saber si son iguales o no.

; (define peter-acc (make-account 100))
; (define paul-acc (make-account 100))

(define peter-acc (make-account 100))
(define paul-acc peter-acc)

((paul-acc 'withdraw) 50)
((peter-acc 'withdraw) 50)

; De la primera manera, dos cuentas separadas que hacen cada una lo suyo pero, de la segunda manera, se 
; juntan las cuentas y ahora las dos son la misma. El mismo objeto tiene dos nombres distintos.

    ; Pitfalls of imperative programming

; Esta mas complejo todo esto de imperativo y si cambias el orden de las cosas tienes distintos resultados.
; Hay que tener mucho cuidado


#| 3.2The Environment Model of Evaluation |#

; Vamos a ver como se esta gestionando esto para guardar las cosas y como se relacionan.

; En lugar de ver las variables como simples nombres para valores, estas se consideran "lugares" 
; donde se almacenan valores, organizados en entornos.

; Un entorno es una secuencia de marcos que asocian variables con valores. Cada marco puede apuntar 
; a un entorno "global" o a otro marco, formando una jerarquía. Si una variable no está en el marco 
; actual, se busca en los marcos superiores. Si no se encuentra, la variable está no vinculada.

; El modelo de entorno es crucial porque define el contexto en el que se evalúan las expresiones. 
; Por ejemplo, el significado de ( + 1 1 ) depende de que el símbolo + esté vinculado a una operación
; de suma en el entorno global. Este enfoque permite manejar asignaciones y variables de manera 
; más robusta.
; Además, un marco puede ocultar valores de variables de marcos superiores 
; (como cuando una variable se redefine en un marco más cercano).
; Si tu tienes definido x, da igual la de arriba de la gerarquia que vas a usar la tuya.

#| 3.2.1The Rules for Evaluation |#

Este modelo introduce el concepto de entornos y marcos para gestionar las variables 
y su alcance de manera más detallada.

Resumen:
Evaluación de combinaciones:
    Evaluar las subexpresiones.
    
    Aplicar el operador a los operandos.

Creación de procedimientos:
    Los procedimientos se crean evaluando expresiones λ en un entorno.

    Un procedimiento consta de código (cuerpo y parámetros) y un puntero al entorno donde se evaluó.
    
    Por ejemplo, (define (square x) (* x x)) equivale a (define square (lambda (x) (* x x))). 
    Aquí, el procedimiento square queda vinculado al entorno global.

Aplicación de procedimientos:
    Se crea un nuevo entorno con un marco que vincula los parámetros formales a los 
    valores de los argumentos.
    
    El entorno que rodea este marco es el indicado por el procedimiento.
    
    El cuerpo del procedimiento se evalúa dentro de este nuevo entorno.

Ejemplo: Evaluar (square 5) crea un nuevo entorno donde x está vinculado a 5, 
y el cuerpo (* x x) se evalúa como 25.

Reglas del modelo de entornos:
    Al aplicar un procedimiento:
        Se construye un marco con los parámetros formales vinculados a los argumentos.
        El cuerpo del procedimiento se evalúa en el nuevo entorno.

    Al crear un procedimiento:
        Se evalúa una expresión λ en un entorno dado.
        Se genera un objeto que incluye el texto del λ y un puntero al entorno de creación.

    Definir (define):
        Crea una vinculación en el marco actual.

    Asignar (set!):
        Localiza la variable en el entorno y modifica su valor. Si no está vinculada, genera un error.

Importancia del modelo: Aunque más complejo que el modelo de sustitución, el modelo de entornos
describe correctamente cómo un intérprete evalúa expresiones y sirve como base para implementar
un intérprete funcional, como se verá en el Capítulo 4.

Imagen ilustrativa:
#|
Global Environment
------------------------
| other variables      |
| square:  ------------|--------> Procedure
------------------------

Procedure:
  Parameters: x
  Body: (* x x)
  Enclosing environment: Global Environment

Call to (square 5):
  Creates a new environment (E1)
  
Environment E1:
------------------------
| x: 5                 |  ---> Enclosing environment: Global Environment
------------------------

Result: (* x x) => (* 5 5) = 25
|#


#| 3.2.2Applying Simple Procedures |#

; Es analizar un ejemplo a ver que pasa (mirar en el libro pq lleva fotos)
; https://sarabander.github.io/sicp/html/3_002e2.xhtml#g_t3_002e2:~:text=3.2.2,Applying%20Simple%20Procedures

; Definición de procedimientos:
;     Al evaluar las definiciones de square, sum-of-squares y f en el entorno global, se crean objetos de procedimiento. Cada objeto contiene el código del procedimiento y un puntero al entorno global.

; Evaluación de `(f 5):
;     Se crea un nuevo entorno (E1) donde el parámetro a se vincula a 5.
;     Dentro de E1, se evalúa el cuerpo de f:
;     (sum-of-squares (+ a 1) (* a 2)).

; Evaluación de subexpresiones:
;     Los valores (sum-of-squares, 6, 10) se obtienen evaluando (+ a 1) y (* a 2).
;     Se aplica sum-of-squares a los argumentos 6 y 10, creando un nuevo entorno (E2) donde x y y están vinculados a estos valores.

; Llamadas a square:
;     Cada llamada a square crea un nuevo entorno:
;     En E3, x se vincula a 6 para evaluar (* x x).
;     En E4, x se vincula a 10 para evaluar (* x x).
    
;     Los valores se suman en sum-of-squares, y el resultado se devuelve a f.

; Puntos clave:

; Cada llamada a un procedimiento crea un nuevo entorno que mantiene separadas las variables locales.
; Los entornos apuntan al entorno indicado por el objeto de procedimiento, en este caso, el global.


#| 3.2.4Internal Definitions |#

; se introduce la idea de que los procedimientos pueden tener definiciones internas, 
; lo que lleva a una estructura de bloques. (ya lo habiamos hablado vaya) pero ahora mola mas:

; Modelo de Entornos:

; Global Environment: 
;     sqrt es un símbolo en el entorno global, vinculado a un objeto procedimiento. 
;     Al llamar a sqrt con un argumento (en este caso, 2), se crea un nuevo entorno (E1), 
;     que tiene como parámetro x el valor 2.

; Definiciones Locales: 
;     Dentro de sqrt, se definen tres procedimientos (good-enough?, improve, y sqrt-iter), 
;     los cuales se agregan al marco de E1. Cada uno de estos procedimientos tiene su propio
;     entorno que se vincula a E1.

; Ejecución de Procedimientos Locales: 
;     Al evaluar (sqrt-iter 1.0) dentro de E1, se crea un nuevo entorno (E2), 
;     donde el parámetro guess de sqrt-iter se vincula a 1. Al llamar a good-enough? 
;     dentro de sqrt-iter, se crea otro entorno (E3) en el que guess se vincula a 1. 
;     Sin embargo, aunque sqrt-iter y good-enough? tienen un parámetro llamado guess, 
;     son variables distintas en entornos diferentes.

; Acceso a Variables Externas: 
;     En good-enough?, el símbolo x se refiere a la variable x definida en E1 
;     (es decir, el valor pasado a sqrt), lo que permite que los procedimientos 
;     internos accedan a las variables del entorno que los contiene.

; (Hay que poner alguna foto de esto que lo explica mejor vaya)


#| 3.3 Modeling with Mutable Data |#