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
      (begin
        (set! balance (- balance amount))
        balance)
      "Insufficient funds"))

; Esto se puede hacer gracias al set! que permite cambiar el valor a una variable ya definida.
; Si nos fijamos tambien usa begin para hacer varias cosas a la vez pero eso ya lo habiamos visto

; Para terminar de definir un objeto bien y que tenga sus metodos podemos usar dispatch

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond
      [(eq? m 'withdraw) withdraw]
      [(eq? m 'deposit) deposit]
      [else (error "Unknown request:
                 MAKE-ACCOUNT" m)]))
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

; Este modelo introduce el concepto de entornos y marcos para gestionar las variables
; y su alcance de manera más detallada.

; Resumen:
; Evaluación de combinaciones:
;     Evaluar las subexpresiones.

;     Aplicar el operador a los operandos.

; Creación de procedimientos:
;     Los procedimientos se crean evaluando expresiones λ en un entorno.

;     Un procedimiento consta de código (cuerpo y parámetros) y un puntero al entorno donde se evaluó.

;     Por ejemplo, (define (square x) (* x x)) equivale a (define square (lambda (x) (* x x))).
;     Aquí, el procedimiento square queda vinculado al entorno global.

; Aplicación de procedimientos:
;     Se crea un nuevo entorno con un marco que vincula los parámetros formales a los
;     valores de los argumentos.

;     El entorno que rodea este marco es el indicado por el procedimiento.

;     El cuerpo del procedimiento se evalúa dentro de este nuevo entorno.

; Ejemplo: Evaluar (square 5) crea un nuevo entorno donde x está vinculado a 5,
; y el cuerpo (* x x) se evalúa como 25.

; Reglas del modelo de entornos:
;     Al aplicar un procedimiento:
;         Se construye un marco con los parámetros formales vinculados a los argumentos.
;         El cuerpo del procedimiento se evalúa en el nuevo entorno.

;     Al crear un procedimiento:
;         Se evalúa una expresión λ en un entorno dado.
;         Se genera un objeto que incluye el texto del λ y un puntero al entorno de creación.

;     Definir (define):
;         Crea una vinculación en el marco actual.

;     Asignar (set!):
;         Localiza la variable en el entorno y modifica su valor. Si no está vinculada, genera un error.

; Importancia del modelo: Aunque más complejo que el modelo de sustitución, el modelo de entornos
; describe correctamente cómo un intérprete evalúa expresiones y sirve como base para implementar
; un intérprete funcional, como se verá en el Capítulo 4.

; Imagen ilustrativa:
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

; Ahora podemos representar objetos muy bien pero falta todavia mas. Datos mutables
; Es decir, datos que pueden cambiar de estado.

; Ejemplo práctico: Un sistema bancario donde los saldos de las cuentas cambian.
;   Solución: Introducir operaciones llamadas mutadores, que permiten modificar datos existentes.
;   Ejemplo:
;     (set-balance! ⟨account⟩ ⟨new-value⟩)
;     Esta operación cambia el saldo de una cuenta a un nuevo valor.

; Ahora vamos a extender el uso de pares como bloques básicos:
;   Los pares ya los hemso usado en el capítulo 2 para construir secuencias y árboles.
;   Ahora, se introducen mutadores para pares, ampliando su funcionalidad:
;   Con estos, los pares pueden representar estructuras de datos más complejas.

#| 3.3.1Mutable List Structure |#

; Las operaciones tradicionales sobre pares, como cons, car y cdr, son fundamentales para construir
;  y manipular estructuras de listas en Scheme. Estas operaciones permiten crear nuevas estructuras
; (con cons) y acceder a las partes de dichas estructuras (con car y cdr).
; Sin embargo, tienen una limitación importante: no permiten modificar las estructuras de lista existentes.
; Por ejemplo, operaciones como append o list, que también trabajan con listas, son incapaces de alterar
; las estructuras, ya que están construidas en torno a cons, car y cdr.

; Para superar esta limitación, se introducen dos nuevas operaciones mutadoras: set-car! y set-cdr!,
; que permiten modificar directamente los pares y, con ello, alterar las estructuras de listas.

; Es cambiar el puntero. Ahora apunta a otro lugar y queda lo otro suelto.
; Ejemplo:
; Supongamos que x está ligado a la lista ((a b) c d) y y está ligado a la lista (e f).
; Al ejecutar (set-car! x y), el car de x es reemplazado por la lista y.
; El resultado es que x ahora representa la lista ((e f) c d), y el segmento (a b)
; queda desvinculado de la estructura.
; (lo mismo con el cdr)

; No es lo mismo que cons. Antes teniamos que crear una lista nueva completa para cambiar algo.
; Ahora podemos directamente alterar esa lista sin necesidad de crear nada nuevo. Solo se cambian punteros.

; Compartición de pares:
; Al construir estructuras de datos con cons, es común que los mismos pares sean compartidos por
; diferentes partes de una estructura.

; Por ejemplo:
(define x (list 'a 'b))
(define z1 (cons x x))
; En este caso, el par x es compartido por el car y el cdr de z1. Esto genera una estructura interconectada
; donde múltiples partes pueden referirse al mismo objeto en memoria.

; En contraste:
(define z2 (cons (list 'a 'b) (list 'a 'b)))
; Aunque z2 tiene listas que aparentan ser iguales ((a b)), estas listas son distintas porque se crearon
; como nuevos pares. Sin embargo, los símbolos 'a y 'b dentro de estas listas son compartidos porque solo
; puede haber un simbolo con el mismo nombre.

#| 3.3.2Representing Queues |#
; Ahora vamos a ver como representar colas con esta info (estructuras de datos vaya).
; Con la info de antes no podiamos implementar estas cosas pero ahroa con los datos mutables si.

; Definición y características de una cola
;   Cola vacía: No contiene elementos.

; Operaciones principales:
;   Constructor: (make-queue) crea una cola vacía.

; Selectores:
;   (empty-queue? ⟨queue⟩): Verifica si la cola está vacía.
;   (front-queue ⟨queue⟩): Retorna el elemento al frente de la cola.

; Mutadores:
;   (insert-queue! ⟨queue⟩ ⟨item⟩): Inserta un elemento en la parte trasera.
;   (delete-queue! ⟨queue⟩): Elimina el elemento al frente.

; Todo esto es igual que lo de estructuras de datos.

; El frente de la cola es el car.
; Insertar un elemento implica añadirlo al final (rear), lo que requiere recorrer la lista completa,
; una operación costosa de Θ(𝑛) Θ(n). Por ello se añade un puntero adicional que apunte al final.
; Así , insertar un elemento se reduce a actualizar el puntero del final.

; Ahora a ver como se implementan las cosas:

; La cola se manipula unicamente con los dos punteros que tenemos. Uno al principio y otro al final.
(define (front-ptr queue)
  (car queue))
(define (rear-ptr queue)
  (cdr queue))
(define (set-front-ptr! queue item)
  (set-mcar! queue item))
(define (set-rear-ptr! queue item)
  (set-mcdr! queue item))

; Ahora a ver como creamos la cola y añadimos y quitamos cosas:

;; Crea una nueva cola vacía.
;; La cola se representa como un par (front . rear),
;; donde ambos punteros inicializan como listas vacías.
(define (make-queue)
  (cons '() '()))

;; Verifica si la cola está vacía.
;; Una cola se considera vacía si su puntero delantero (front-ptr) es '().
(define (empty-queue? queue)
  (null? (front-ptr queue)))

;; Retorna el primer elemento de la cola (frente).
;; Si la cola está vacía, lanza un error.
(define (front-queue queue)
  (if (empty-queue? queue)
      ;; Error si la cola está vacía.
      (error "FRONT called with an empty queue" queue)
      ;; Si no está vacía, toma el car del puntero delantero.
      (car (front-ptr queue))))

;; Inserta un nuevo elemento al final de la cola.
;; Si la cola está vacía, actualiza tanto el puntero delantero como el trasero.
;; Si no está vacía, actualiza solo el puntero trasero.
(define (insert-queue! queue item)
  ;; Creamos un nuevo par que contiene el item como car y '() como cdr.
  (let ([new-pair (cons item '())])
    (cond
      ;; Si la cola está vacía:
      [(empty-queue? queue)
       ;; Ambos punteros (front y rear) apuntan al nuevo par.
       (set-front-ptr! queue new-pair)
       (set-rear-ptr! queue new-pair)
       ;; Retornamos la cola modificada.
       queue]
      ;; Si la cola no está vacía:
      [else
       ;; Actualizamos el cdr del último par para que apunte al nuevo par.
       (set-mcdr! (rear-ptr queue) new-pair)
       ;; Cambiamos el puntero trasero para que apunte al nuevo par.
       (set-rear-ptr! queue new-pair)
       ;; Retornamos la cola modificada.
       queue])))

;; Elimina el primer elemento de la cola.
;; Si la cola está vacía, lanza un error.
(define (delete-queue! queue)
  (cond
    ;; Error si la cola está vacía.
    [(empty-queue? queue) (error "DELETE! called with an empty queue" queue)]
    ;; Si la cola no está vacía:
    [else
     ;; El puntero delantero ahora apunta al siguiente par.
     (set-front-ptr! queue (cdr (front-ptr queue)))
     ;; Retornamos la cola modificada.
     queue]))

; si estamos usando mcar o algo con modificaciones, tenemso que usar lo de m en todos los lados
; porque no son la misma estructura asi que no se pueden compartir

#| 3.5 Streams |#

; Problema de las Asignaciones:

; Modelización tradicional:
; Normalmente, usamos variables y asignaciones para representar cosas que cambian con el tiempo.
; Esto imita cómo funcionan los objetos en el mundo real, pero hace que el código sea más complicado
; de manejar.

; Un enfoque diferente:
; En lugar de trabajar con variables que cambian, podemos pensar en el comportamiento completo de algo
; a lo largo del tiempo, como si fuese una función matemática. Si dividimos el tiempo en pasos
; (como fotogramas), podemos representar esto como una lista de valores.

; ¿Qué son los streams?
; Son como listas, pero con truco: no se crean todos los valores de golpe, sino que los calculamos
; solo cuando los necesitamos. Esto permite manejar listas gigantescas (o infinitas) sin problemas
; de memoria.

; Lo bueno de los streams:
; No necesitas usar variables que cambian, lo que simplifica el código.
; Se evitan muchos de los problemas que vienen con las asignaciones.

; Lo malo de los streams:
; No son la solución mágica: también traen sus propios retos.
; Todavía no está claro si este enfoque es siempre mejor para hacer el código más fácil de entender
; y mantener.

#| 3.5.1Streams Are Delayed Lists |#

; En programación, podemos usar funciones como map, filter o accumulate para procesar listas de manera
; elegante y compacta.
; El problema es que trabajar con listas puede ser muy ineficiente en términos de tiempo y memoria,
; especialmente cuando las listas son enormes.

; Problema con listas tradicionales:
; Al usar listas, cada operación genera nuevas listas intermedias que ocupan mucho espacio.
; Ejemplo: Si quieres el segundo número primo entre 10,000 y 1,000,000, crearás una lista gigante y la filtrarás,
;  incluso si solo necesitas un par de resultados.

; ¿Qué son los streams?
; Son como listas, pero "perezosas". En lugar de construir toda la lista de golpe, construyen los elementos
; solo cuando los necesitamos.
; Esto permite escribir código elegante como si trabajaras con listas completas, pero sin gastar recursos
; innecesarios.

; Cómo funcionan los streams:
; Usan una técnica llamada evaluación diferida (delayed evaluation):
; El primer elemento (car) de un stream se calcula inmediatamente.
; El resto (cdr) no se calcula hasta que lo necesites.
; Esto es como hacer una "promesa" de calcular algo más adelante, solo si es necesario.

; Construcción de streams:
; Usa el constructor cons-stream para crear streams:
; (cons-stream x y) ; x es el primer valor, y es el resto retrasado.
; Los elementos se acceden con:
; stream-car para obtener el primer valor.
; stream-cdr para calcular/acceder al resto.

; Ventajas de los streams:
; Elegancia: Puedes escribir código como si estuvieras procesando listas completas.
; Eficiencia: Solo se calculan los datos que realmente necesitas.
; Ejemplo: Puedes calcular el segundo primo en un intervalo sin construir listas gigantes.
; Operaciones comunes con streams:

; Referencia por índice:
(define (stream-ref s n)
  (if (= n 0)
      (stream-first s)
      (stream-ref (stream-rest s) (- n 1))))

; Mapeo (aplicar una función a cada elemento):
(define (stream-map proc s)
  (if (stream-empty? s)
      empty-stream
      (stream-cons (proc (stream-first s)) (stream-map proc (stream-rest s)))))

; Iterar sobre un stream:
(define (stream-for-each proc s)
  (if (stream-empty? s)
      'done
      (begin
        (proc (stream-first s))
        (stream-for-each proc (stream-rest s)))))

; Stream-for-each is useful for viewing streams:
(define (display-stream s)
  (stream-for-each displayln s))

(define (display-line x)
  (newline)
  (display x))

; Para acceder a los elementos no es con esto:
(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

; Es con stream-first y stream-rest

#| (empty-stream) ; empty stream object
(stream-empty? s) ; Check for empty
(stream-cons first rest) ; Make a new stream
(stream-first s) ; First element
(stream-rest s) ; Remaining elements
(stream-for-each proc s) ; Apply proc to each item |#

; Claves técnicas:
; Streams se construyen con cons-stream, que en realidad es como un par (cons) donde la parte del resto
; (cdr) es retrasada con un comando especial llamado delay.
; Para evaluar este resto, usamos force.

; Resumen de los streams:
; Son una forma eficiente de manejar datos secuenciales.
; Solo calculan lo que necesitas, cuando lo necesitas.
; Aunque parecen listas normales, la diferencia está en cuándo se evalúan las partes (al construir vs. al usar).

#| The stream implementation in action |#

; Paso a paso:
; Creación del intervalo con stream-enumerate-interval:
; Es una versión de streams del procedimiento enumerate-interval. Define un stream que genera números
; en el rango deseado:

(define (stream-enumerate-interval low high)
  (if (> low high)
      empty-stream
      (stream-cons low (stream-enumerate-interval (+ low 1) high))))

; Llamando a (stream-enumerate-interval 10000 1000000):
; Devuelve un stream que tiene como car el número 10,000.
; El cdr es una promesa de calcular el resto del intervalo cuando se necesite:

(cons 10000 (delay (stream-enumerate-interval 10001 1000000)))

; Filtrado de primos con stream-filter:
; Este procedimiento selecciona solo los números primos del stream generado.
; Es una versión en streams del procedimiento filter:

(define (stream-filter pred stream)
  (cond
    [(stream-empty? stream) empty-stream]
    [(pred (stream-car stream))
     (stream-cons (stream-first stream) (stream-filter pred (stream-rest stream)))]
    [else (stream-filter pred (stream-rest stream))]))

; Comienza probando el car del stream, 10,000, que no es primo.
; Entonces fuerza el cálculo del siguiente elemento (stream-cdr),
; que evalúa la promesa del intervalo retrasado:

(cons 10001 (delay (stream-enumerate-interval 10002 1000000)))
; Esto se repite hasta encontrar el primer número primo, 10007:

; (stream-cons 10007 (stream-filter prime? (stream-cdr rest-of-stream)))

; Cálculo del segundo primo:
; En el stream resultante, el primer número primo encontrado es 10,007.
; Al forzar el stream-cdr, se busca el siguiente número primo, 10,009,
; deteniéndose una vez encontrado:

; (cons 10009 (delay (stream-filter prime? (stream-cdr rest-of-stream))))

; Eficiencia del cálculo:
; Elementos evaluados: Solo los necesarios para encontrar los primeros dos primos.
; Números probados: Se calculan y filtran uno por uno, nunca generando toda la lista completa.
; Esto demuestra cómo los streams permiten "evaluación bajo demanda", donde cada etapa del proceso
; activa solo la cantidad de cálculo necesaria para satisfacer la siguiente.

; Programación dirigida por demanda:
; Los streams separan la aparente estructura de nuestras funciones de la realidad del cálculo.
; Aunque escribimos código como si los streams existieran completos, el cálculo ocurre incrementalmente,
; optimizando el uso de recursos.
; Este enfoque combina lo mejor de la programación elegante y la eficiencia de recursos.

#| Crear delay y force |#

; delay: Retrasar la evaluación
; El objetivo de delay es empaquetar una expresión para evaluarla más tarde.
; Esto se puede lograr tratándola como el cuerpo de una función que no recibe argumentos:

; (delay ⟨exp⟩)

; Esto es equivalente a escribir:

; (lambda () ⟨exp⟩)

; force: Evaluar el resultado retrasado
; force simplemente llama a esta función que encapsula la expresión:

; (define (force delayed-object) (delayed-object))

; Optimización con memoization
; Un problema común ocurre cuando una expresión retrasada se evalúa múltiples veces. Sin optimización,
; cada vez que llamamos a force, el cálculo se repite, lo que puede ser ineficiente, especialmente en
; programas recursivos que usan streams.

; Solución: Utilizar memoization para guardar el valor calculado en la primera evaluación.

; Si el objeto retrasado ya fue evaluado, force devuelve el valor almacenado.
; Si no, calcula el valor, lo guarda y luego lo devuelve.
; Implementación de memo-proc
; memo-proc toma como argumento un procedimiento (de cero argumentos) y devuelve una versión optimizada
; que almacena el resultado de su primera ejecución:

(define (memo-proc proc)
  (let ([already-run? false] ; Bandera para saber si ya se ejecutó
        [result false]) ; Valor del resultado memoizado
    (lambda ()
      (if (not already-run?) ; Si no se ha ejecutado:
          (begin
            (set! result (proc)) ; Calcula y guarda el resultado
            (set! already-run? true) ; Marca como ya ejecutado
            result)
          result)))) ; Si ya se ejecutó, devuelve el resultado almacenado

; Redefinición de delay
; Con memo-proc, redefinimos delay para que sea equivalente a:

; (memo-proc (lambda () ⟨exp⟩))

; Redefinición de force
; force sigue siendo el mismo:

; (define (force delayed-object)
;   (delayed-object))

#| 3.5.2 Infinite Streams |#

; Los streams infinitos son una poderosa herramienta que permite representar secuencias que
; conceptualmente no tienen fin. Aunque no almacenamos todos los elementos de un stream infinito,
; podemos manipularlo como si existiera completo, generando solo la porción necesaria en el
; momento de la evaluación.

; Streams infinitos básicos:
; - Secuencia de enteros positivos
;   Podemos definir un stream infinito de enteros positivos de la siguiente manera:

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

; integers es un par donde el car es 1 y el cdr es una promesa de calcular los enteros a partir de 2.
; En cualquier momento, solo se genera la parte del stream que necesitemos.

; Filtrar enteros
; Utilizando integers, podemos generar streams derivados, como enteros que no son divisibles por 7:

(define (divisible? x y)
  (= (remainder x y) 0))
(define no-sevens (stream-filter (lambda (x) (not (divisible? x 7))) integers))
; Ejemplo:
; Obtener el elemento 100 del stream:
(stream-ref no-sevens 100) ; Resultado: 117

; - Números de Fibonacci
; Podemos definir el stream infinito de números de Fibonacci con un generador recursivo:

(define (fibgen a b)
  (stream-cons a (fibgen b (+ a b))))
(define fibs (fibgen 0 1))

; fibs es un par donde el car es 0 y el cdr es una promesa de calcular el resto de la secuencia de Fibonacci.
; Evaluar el cdr genera el siguiente número, y así sucesivamente.

; Definición implícita de streams
; Además de usar generadores explícitos, los streams infinitos también se pueden definir de manera implícita utilizando evaluación diferida.

(define ones (stream-cons 1 ones))
; ones es un par cuyo car es 1 y cuyo cdr es una promesa de evaluar ones nuevamente.

; add-streams suma elemento por elemento dos streams:
(define (add-streams s1 s2)
  (stream-map + s1 s2))

; Stream de enteros positivos
; Usando operaciones con streams, podemos redefinir los enteros positivos:

(define integers2 (stream-cons 1 (add-streams ones integers2)))

; Esta definición se basa en que, en cualquier momento, existe suficiente información generada
; para calcular los siguientes elementos.

; Números de Fibonacci
; También podemos redefinir fibs de forma implícita:

(define fibo (stream-cons 0 (stream-cons 1 (add-streams (stream-rest fibo) fibo))))
; Aquí, cada elemento se genera sumando el stream fibs consigo mismo desplazado un lugar. Por ejemplo:

; fibs:    0  1  1  2  3  5  8 13 ...
; cdr(fibs):   1  1  2  3  5  8 13 ...

; Streams útiles
; Multiplicar elementos por una constante
; scale-stream permite escalar cada elemento de un stream por un factor dado:

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

; Ejemplo:
; Stream de potencias de 2:
(define double (stream-cons 1 (scale-stream double 2)))
; Genera: 1, 2, 4, 8, 16, 32, ...
